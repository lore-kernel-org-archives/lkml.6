Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7BFC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EBF21C1A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PoWZoCKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EBF21C1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeHIFZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 01:25:47 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39810 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbeHIFZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 01:25:47 -0400
Received: by mail-oi0-f67.google.com with SMTP id d189-v6so7406237oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 20:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1qyGUUVbIMvKFt6F5OEPjh0AGjXlZFtqZWjag6+C7w0=;
        b=PoWZoCKXGLdZL67YcUujNsPGVDWDM7Io/MJGN0B6AOlg0qoYjchft/++93GOtkbhdW
         Be9bY1lFG29Kh2DAZ0sYSCtschlKAtwhQN7kJ9vJHetVqNBDQ97QZOyKQcNuNP//Ezi2
         mQjoN63tIqkbKD9Gbu2KGEWogq9k3ZrjCdVFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1qyGUUVbIMvKFt6F5OEPjh0AGjXlZFtqZWjag6+C7w0=;
        b=QnHy3YDwneeRmL3QiWFn0RRTimHqUv1ZbhWehPQbfUSmqzGfe24evSde5y6cGB0mi2
         sM9JTwb2idL5HJ9dUHysp2jMEdlL5Lg0P7VG3mRiTZeKQfC7lWRiPeVaPq8SsEt9m/JX
         CWMpKFfy2F9qCLo27U3SG34iUZZWRazJqLljz1nNq4CORqICVTztX6vTusCdXUzpd1FA
         XOGXBF8AZP9X9OckUPzOwu/U/6mlseuw4RZOSVR+IH38HCYztAVEf3n/WtvbJk3cQRCJ
         DoeEf5aNa5JayMHTrVHQ2uDuQJ24hMCsttWG9uj22+zF6vKOEfBkYwoMrHZLrdte19hJ
         6pEg==
X-Gm-Message-State: AOUpUlFLwsBZe/X/5cfo/aidI4hEsqDiwFow3hkDEH3qoqDUSa9RDiXg
        bYEYtOP65X4asZ1O+5RDMPPkVHl8GFj6WCqyEJLFSg==
X-Google-Smtp-Source: AA+uWPx73jKUR8mR1hpJZcVeEVovf2G/KWJWJY2eLH7B3Wkk3r4GMG45i4kfOxmq+Lz6uK723pTax9OwOwluk99E9zk=
X-Received: by 2002:aca:d846:: with SMTP id p67-v6mr376461oig.42.1533783791797;
 Wed, 08 Aug 2018 20:03:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 20:03:11 -0700 (PDT)
In-Reply-To: <1533754621.2283.270.camel@impinj.com>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk> <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
 <20180808095025.GB9346@sirena.org.uk> <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
 <20180808105451.GE9346@sirena.org.uk> <1533754621.2283.270.camel@impinj.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 9 Aug 2018 11:03:11 +0800
Message-ID: <CAMz4kuKwfBB8-8o5s8FQadFSFiD8KU=qNZYQjCWOfc-QpuVRSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller documentation
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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

Hi Trent,

On 9 August 2018 at 02:57, Trent Piepho <tpiepho@impinj.com> wrote:
> On Wed, 2018-08-08 at 11:54 +0100, Mark Brown wrote:
>> On Wed, Aug 08, 2018 at 06:35:28PM +0800, Baolin Wang wrote:
>> > On 8 August 2018 at 17:50, Mark Brown <broonie@kernel.org> wrote:
>> > > Right, I don't think we added this yet (if we did I can't see
>> > > it).  I'd
>> > > add a new field to spi_transfer for this, then other controllers
>> > > with
>> > > the same support can implement it as well and drivers can start
>> > > using
>> > > it too.
>> > OK. So I will name the new filed as 'word_delay', is it OK for you?
>>
>> Sounds good, yes.
>
> Should it be in =C2=B5s like the existing iter-transfer delay?  I think
> perhaps units of cycles of the SPI clock make more sense?

Since some SPI controllers just want some interval values (neither =C2=B5s
unit nor cycles unit ) set into hardware, and the hardware will
convert to the correct delay time automatically. So I did not force
'word_delay' unit as =C2=B5s or cycle, and just let the slave devices
decide the unit which depends on the SPI hardware requirement.

--=20
Baolin Wang
Best Regards
