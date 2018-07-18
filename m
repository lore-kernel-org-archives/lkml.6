Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19F4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BF32084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uP1CBDMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BF32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbeGRKBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:01:51 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46798 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730226AbeGRKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:01:51 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so7482436oie.13;
        Wed, 18 Jul 2018 02:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gj08FFLbA8hUUi13LhgfNvVWsE0wVr+ZLERKQcoGc9w=;
        b=uP1CBDMHjzq9tp7Ok08cKCgS8doY+AOVI3XFddAuUeJsCaGfTsf1LT10+k64PHnkXb
         hl8/MgrfmyMFLZ0zd43sGsjSk7wJ9yDo93Hz0KcVqAXDwN0K2AaV74bS67Cv47Mu9Zcg
         GPt8+gmhQNqHTGPgjcg9eUOdOPINH4adGXILxNU8WLoO4YbcmVj4J1P6XDAjZ87MAvCb
         2CUhnu4O8ZNTQikkVEVY+Nts345/cvZxVGlOHZ5P4Zz1z96+DyO40Tb4R+AHwrjNcciO
         B1N7BujHjILm7ZF41saYF/fH30duj2nXosSz0zKUvBGUc/3lUxHrhntoPXaaWQ6J8ZHY
         AODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gj08FFLbA8hUUi13LhgfNvVWsE0wVr+ZLERKQcoGc9w=;
        b=U62DE+CNOFfpdV99cykLcpyW3ctdAV393NCFU9AnsbD7BYDGwghGcalrPMklR8CA2d
         rlNK0gTv8jeu6YotMsSjcKl2mx48+J/tH02d5NbhhKbmZda9FyFgixh27/NXl5RpozuD
         N5sfuyHOlgydhBuHQ/NENwdtCGaY6e9iaaa2suvyGI6j9NifXMOKpGnSLG7XAldKD2WZ
         XlotG1oOGK0suj+xD8Mo2yeigSAGZovwkN/Zva8rO04umiCk9B48amk3wiexfzXCyDRx
         0qNJMsAVZNO+0L2FmviUq7yMrto90BSNpPjzgDwCdeGcC2PAl3KD9scrrLdmkqHzPIAl
         vW7w==
X-Gm-Message-State: AOUpUlFy8/tnHFaxR43DedWgigkxO6lAaw7+IghOGv7Rq2h6k50iEXss
        938ADbC+GCy44Q6XdljloWn0n4GkDNgbMDaN1HBXfQ==
X-Google-Smtp-Source: AAOMgpfX+3jzazjMYa2paLS97GUhdQSsFeDNJ+qqYKMDZWXRpJUM7liqAmfX1ADVO1d+wQ+hA9ddxdbrj4lPlf8guX4=
X-Received: by 2002:aca:b48b:: with SMTP id d133-v6mr5046053oif.165.1531905891072;
 Wed, 18 Jul 2018 02:24:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b33:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 02:24:30
 -0700 (PDT)
In-Reply-To: <CAJKOXPdXYz77Bqyjr3HK+EA0HpEABPqmPOD0f5ew-yq2SFVpVQ@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
 <CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com> <CAJKOXPdXYz77Bqyjr3HK+EA0HpEABPqmPOD0f5ew-yq2SFVpVQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 Jul 2018 14:54:30 +0530
Message-ID: <CANAwSgRFehdmYZvPL3yD1=Ng_w1Yhtij=nvZEOqkof7zj8fcwA@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos platform
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000779809057142a212"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000779809057142a212
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof

On 18 July 2018 at 11:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 17 July 2018 at 22:23, Anand Moon <linux.amoon@gmail.com> wrote:
>> Hi Krzysztof
>>
>> On 17 July 2018 at 17:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> Hi Anand,
>>>
>>> Thanks for patch.
>>>
>>> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>>>> clk_summary do not show tmu_apbif clk enable, so replace
>>>> the clk_prepare with clk_prepare_enables to enable tmu clk.
>>>
>>> This is not valid reason to do a change. What is clk_summary does not
>>> really matter. Your change has negative impact on power consumption as
>>> the clock stays enabled all the time. This is not what we want... so
>>> please explain it more - why you need the clock to be enabled all the
>>> time? What is broken (clk_summary is not broken in this case)?
>>>
>>
>> Opps I could not explain some more in my commit message.
>>
>> Actually TMU sensor for Exynos process are controlled by so external clk
>>
>> Exynos4412 have VDD18_TS sensor which controls the CLK_SENSE tmu.
>> Exynos5422 have VDD18_TS01 / VDD18_TS23 / VDD18_TS4 sensor which
>> control the CLK_SENSE tmu.
>>
>> So as per my understanding tmu is clk driver which control the flow  PMIC.
>>
>> clk_prepare_enable combine clk_prepare and clk_enable
>> and clk_disable_unprepare combine clk_disable and clk_unprepare.
>>
>> most of the driver prefer clk_prepare_enable and clk_disable_unprepare.
>>
>> clk_summary is just a reference looking point where we could check the
>> clk is enable/disable.
>>
>> what is broken ?
>> I still few more parameter need to tuned to configure the tmu driver.
>
> I am sorry but I am still unable to see what is broken and what are
> you trying to fix. I asked what is broken and you replied that there
> is a sensor, there is a clock, drivers use clk_prepare_enable and some
> more parameter need to be tuned... None of these are answers to
> question - what is broken. How can I reproduce the problem?
>
> Best regards,
> Krzysztof

Basically I use thermal testing.

# git clone https://git.linaro.org/power/pm-qa.git
# cd pm-qa
# make -C thermal check

most of the testcase failed on Exynos5422 but some pass on Exynos4412.

Attach is the software overview from Exynos5422 user manual.

I am not able to explain in deep technically, but I have studied other thermal
driver to draw into conclusion that tmu clk's need to be enabled.

If you feel the we should not enable these clk, them I will drop the
clk_prepare_enable check
and resubmit the changes with better commit message.

Best Regards
-Anand

--000000000000779809057142a212
Content-Type: text/plain; charset="US-ASCII"; name="Exynos5422_software_tmu.txt"
Content-Disposition: attachment; filename="Exynos5422_software_tmu.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jjqx60gx0

VGhlIGV4YW1wbGUgb2Ygc29mdHdhcmUgc2VxdWVuY2UgYXMgZm9sbG93czoNClRoZSBwYXJhbWV0
ZXIgbWF5IGJlIGNoYW5nZWQgYWNjb3JkaW5nIHRvIGFuIGFwcGxpY2F0aW9uLg0KLyogUmVhZCB0
aGUgbWVhc3VyZWQgZGF0YSBmcm9tIGUtZnVzZSAqLw0KVHJpbWluZm9fODUgPSBUUklNSU5GT1sx
NTo4XQ0KVHJpbWluZm9fMjUgPSBUUklNSU5GT1s3OjBdDQovKiBDYWxpYnJhdGVkIHRocmVzaG9s
ZCB0ZW1wZXJhdHVyZSBpcyB3cml0dGVuIGludG8gVEhSRVNfVEVNUF9SSVNFIGFuZCBUSFJFU19U
RU1QX0ZBTEwgKi8NCi8qIFJlZmVyIHRvIDEuNi4xICovDQpUSFJFU19URU1QX1JJU0UwID0gMHg0
MDsNClRIUkVTX1RFTVBfUklTRTEgPSAweDUwOw0KVEhSRVNfVEVNUF9SSVNFMiA9IDB4NjA7DQpU
SFJFU19URU1QX1JJU0UzID0gMHg3MDsNClRIUkVTX1RFTVBfRkFMTDAgPSAweDNBOw0KVEhSRVNf
VEVNUF9GQUxMMSA9IDB4NEE7DQpUSFJFU19URU1QX0ZBTEwyID0gMHg1QTsNCi8qIFBhcmFtZXRl
ciBmb3Igc2FtcGxpbmcgaW50ZXJ2YWwgaXMgc2V0ICovDQpTQU1QTElOR19JTlRFUlZBTCA9IDB4
MTsNCi8qIEludGVycnVwdCBlbmFibGUgKi8NCklOVEVOWzI0XSA9MHgxOyAvLyBmb3IgSU5URU5f
RkFMTDINCklOVEVOWzIwXSA9MHgxOyAvLyBmb3IgSU5URU5fRkFMTDENCklOVEVOWzE2XSA9MHgx
OyAvLyBmb3IgSU5URU5fRkFMTDANCklOVEVOWzhdID0weDE7IC8vIGZvciBJTlRFTl9SSVNFMg0K
SU5URU5bNF0gPTB4MTsgLy8gZm9yIElOVEVOX1JJU0UxDQpJTlRFTlswXSA9MHgxOyAvLyBmb3Ig
SU5URU5fUklTRTANCi8qIFRoZXJtYWwgdHJpcHBpbmcgbW9kZSBzZWxlY3Rpb24gKi8NClRIRVJN
X1RSSVBfTU9ERSA9IDB4NDsNCi8qIFRoZXJtYWwgdHJpcHBpbmcgZW5hYmxlICovDQpUSEVSTV9U
UklQX0VOID0gMHgxOw0KLyogQ2hlY2sgc2Vuc2luZyBvcGVyYXRpb24gaXMgaWRsZSAqLw0KdG11
X2lkbGUgPSAwOw0Kd2hpbGUodG11X2lkbGUmMSkgew0KdG11X2lkbGUgPSBUTVVfU1RBVFVTWzBd
Ow0KfQ0KLyogU3RhcnQgc2Vuc2luZyBvcGVyYXRpb24gKi8NClRNVV9DT05UUk9MIHw9IDE7DQoN
CklTUl9JTlRSRVFfVE1VICgpIHsNCi8qIFJlYWQgaW50ZXJydXB0IHN0YXR1cyByZWdpc3RlciAq
Lw0KaW50X3N0YXR1cyA9IElOVFNUQVQ7DQppZihpbnRfc3RhdHVzWzI0XSkgew0KSVNSX0lOVF9G
QUxMMigpOw0KfQ0KZWxzZSBpZihpbnRfc3RhdHVzWzIwXSkgew0KSVNSX0lOVF9GQUxMMSgpOw0K
fQ0KZWxzZSBpZihpbnRfc3RhdHVzWzE2XSkgew0KSVNSX0lOVF9GQUxMMCgpOw0KfQ0KRWxzZSBp
ZihpbnRfc3RhdHVzWzhdKSB7DQpJU1JfSU5UX1JJU0UyKCk7DQp9DQplbHNlIGlmKGludF9zdGF0
dXNbNF0pIHsNCklTUl9JTlRfUklTRTEoKTsNCn0NCmVsc2UgaWYoaW50X3N0YXR1c1swXSkgew0K
SVNSX0lOVF9SSVNFMCgpOw0KfQ0KZWxzZSB7DQokZGlzcGxheSgiU29tZSBlcnJvciBvY2N1cnJl
ZC4uISIpOw0KfQ0KSVNSX0lOVDAgKCkgew0KLyogUGVyZm9ybSBwcm9wZXIgdGFzayBmb3IgZGVj
cmVhc2UgdGVtcGVyYXR1cmUgKi8NCklOVENMRUFSWzBdID0gMHgxOw0KfQ==
--000000000000779809057142a212--
