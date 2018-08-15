Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C69EC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 02:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3957F216E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 02:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXALR1Px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3957F216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeHOFHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 01:07:15 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39289 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeHOFHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 01:07:15 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so37315937oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 19:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=skqZbNutMA/DekEo8deH+lkEyYuc0vfAmIEBSU/rQxQ=;
        b=IXALR1PxaqZaAXvZVfooewp5OvpHuIkuiEmSzaLG3MJk6R53nD83fddTKQV+E6qVch
         ACIhUxmSUmYpclhyfqfFO34aBmKks1D95/k4IIhRlsVwX9crfHCZV0o2/wUWnMtuYip8
         JGkdSmZAyPgbYeAfBu6p3eq06/y6uURsyso+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=skqZbNutMA/DekEo8deH+lkEyYuc0vfAmIEBSU/rQxQ=;
        b=FpXO4UKx7GjutyIe7hUYIAd32HWG/gfoC57QI2eN6O5cF0tgWTtPeoTMIpAcNa16sn
         2bCuCgz4Az+eLdFo6jJfu39v3wTDsbuAPNggjUnrN6DqxAAuNHcRfVwxiSXG99QVYsXn
         1hi+uIIf35IM0n10m17zzNq40AyK1gnHgOxmzuwHgE8ZUmaXy+BJiRKq/W74rqjW3z1U
         qWAt2jE8PLB4NWiDuYChNwUIZzh7rflhFxyl/NxPm4QkKU9q/l4t/TDmwVCV/SmkEgzi
         CkqtPNw3dCQyA9kO+/AY6cSpQRzZ9rsACRX6uvszKG64K5ny4LjW1fb66qRsYPxRDFsw
         qaZg==
X-Gm-Message-State: AOUpUlFspIXiaZitfb5M2YT0qaWxc4iaN12vBzUNmDXbPHBPAZ4tb2y9
        NGV5ZjioVEn1MoBBF92gT2XCSYS/cxd3+7d2VDHVOA==
X-Google-Smtp-Source: AA+uWPxWKJoFjne9PBExfMl+jOAegrIlws+cRn99VzQq19oEvvYmwFjTxqp7UhCtuHKfZRyv5pbGJCsODxjRuCplblI=
X-Received: by 2002:aca:5dc5:: with SMTP id r188-v6mr25689446oib.320.1534299433317;
 Tue, 14 Aug 2018 19:17:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 19:17:12
 -0700 (PDT)
In-Reply-To: <20180814202720.GB26606@rob-hp-laptop>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk> <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
 <20180808095025.GB9346@sirena.org.uk> <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
 <20180808105451.GE9346@sirena.org.uk> <1533754621.2283.270.camel@impinj.com>
 <CAMz4kuKwfBB8-8o5s8FQadFSFiD8KU=qNZYQjCWOfc-QpuVRSw@mail.gmail.com> <20180814202720.GB26606@rob-hp-laptop>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 15 Aug 2018 10:17:12 +0800
Message-ID: <CAMz4kuK=n33V_AcmgmYjHHuXyDAZ+QAh947NL2g3XfOhsg_-gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller documentation
To:     Rob Herring <robh@kernel.org>
Cc:     Trent Piepho <tpiepho@impinj.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "lanqing.liu@spreadtrum.com" <lanqing.liu@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 15 August 2018 at 04:27, Rob Herring <robh@kernel.org> wrote:
> On Thu, Aug 09, 2018 at 11:03:11AM +0800, Baolin Wang wrote:
>> Hi Trent,
>>
>> On 9 August 2018 at 02:57, Trent Piepho <tpiepho@impinj.com> wrote:
>> > On Wed, 2018-08-08 at 11:54 +0100, Mark Brown wrote:
>> >> On Wed, Aug 08, 2018 at 06:35:28PM +0800, Baolin Wang wrote:
>> >> > On 8 August 2018 at 17:50, Mark Brown <broonie@kernel.org> wrote:
>> >> > > Right, I don't think we added this yet (if we did I can't see
>> >> > > it).  I'd
>> >> > > add a new field to spi_transfer for this, then other controllers
>> >> > > with
>> >> > > the same support can implement it as well and drivers can start
>> >> > > using
>> >> > > it too.
>> >> > OK. So I will name the new filed as 'word_delay', is it OK for you?
>> >>
>> >> Sounds good, yes.
>> >
>> > Should it be in =C2=B5s like the existing iter-transfer delay?  I thin=
k
>> > perhaps units of cycles of the SPI clock make more sense?
>>
>> Since some SPI controllers just want some interval values (neither =C2=
=B5s
>> unit nor cycles unit ) set into hardware, and the hardware will
>> convert to the correct delay time automatically. So I did not force
>> 'word_delay' unit as =C2=B5s or cycle, and just let the slave devices
>> decide the unit which depends on the SPI hardware requirement.
>
> This needs to be defined units in DT, not decided by each controller.

Do you mean we should introduce one standard property (maybe named as
'word_delay_unit') to define the word_delay unit?
If we really need to specify the unit of word_delay, I think we can
add comments for spi_tansfer  to specify the unit, which will be
better.

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a64235e..7a72c0a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -711,6 +711,8 @@ extern void spi_res_release(struct spi_controller *ctlr=
,
  * @delay_usecs: microseconds to delay after this transfer before
  * (optionally) changing the chipselect status, then starting
  * the next transfer or completing this @spi_message.
+ * @word_delay: clock cycles to inter word delay after each word size
(set by bits_per_word)
+ * transmission.
  * @transfer_list: transfers are sequenced through @spi_message.transfers
  * @tx_sg: Scatterlist for transmit, currently not for client use
  * @rx_sg: Scatterlist for receive, currently not for client use
@@ -793,6 +795,7 @@ struct spi_transfer {
  u8 bits_per_word;
  u16 delay_usecs;
  u32 speed_hz;
+ u16 word_delay;

  struct list_head transfer_list;
 };


--=20
Baolin Wang
Best Regards
