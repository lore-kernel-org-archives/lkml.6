Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-820325-1521533348-2-16303275037845443758
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521533348; b=CVd9iDDSE5m52juSOQAjv3T7iwIwSJVHRxhiU3LH18Sql5v
    kvjgDPvgoqmO4jLHy+aKXrZU4Ip3C3DTEaYZ6lb8PvHCLmYYQfeAfGxAKuZpmh4g
    Ze75krzJxh+lxZllizYv2LXqkiC9+FTHpmT7p5inOCj/BbOasuvQWluDkuwxGMQC
    qU0Rg9/uhbmpu39lMA/ixatRISN9omN5ZnXQP7mzmAoZhPxec3fXY83f7726ofTH
    ZvDTiwqQGEE17U0v1GEsQnxmxyxwNyojyqQ5hDs2jr34zr9txQnXc9kS5bLqI/fj
    6jshnYzw6o1hDjVKImOHcWlQC0ebFlT2E3uU2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521533348; bh=YPFB+O05sP8XR5IenQG5kuNovC6CPFVhgP7VrX
    Mndgg=; b=VHt7CvV0m2zxJQip0fzVUqJSoz8qs6DQn6+t/55xWtlMOWIflYe+OM
    HKIKWYe1r0w0ydEdAwzrdPJB15IeJMMLNlM31bgoDK2Mq+Eht7+nEdcciY75QqQ7
    J/B1fS8vf6Jdpu74qnuKoj/8IrCeykG7GK7iFHvggNO2YYmtJA/6gTVTrAtKbpns
    SL+0/O2UBKwLMqmaN5PSC8ND0m7iwusj6tAXr41YDXOA5lB4OmPBh0cT4A6rCgak
    sAmKj1VWmmjl5mVN+hbaCe5rSPsaO9f4jvVQUyvpe5hcYBxEwoYohj2+kVuwmyW3
    kysRGsWKHoQsVxmHj/NA2NhRMOfKJn1A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=O1Q0VTdc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Qnyf2cUe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=O1Q0VTdc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Qnyf2cUe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeCTIIN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 04:08:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54098 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbeCTIIL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 04:08:11 -0400
X-Google-Smtp-Source: AG47ELsguFqvmAVGeE22aRGNZbOGTlSBKa6MuwT4WD1wiDTOQ4f5Ho/hRogTYr8/DpNJdrQkEoTdwhqAo+URYyjbzGI=
MIME-Version: 1.0
In-Reply-To: <20180320074241.GB8152@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org> <20180319171854.858515505@linuxfoundation.org>
 <20180319235251.ui2gf3nlg2icbbdx@xps> <20180320074241.GB8152@kroah.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 20 Mar 2018 16:08:09 +0800
Message-ID: <CAKaJLVsL0reHGtY_3CvXK4q4XTCEZeWhcvv1VyVTwbSDdAvF0Q@mail.gmail.com>
Subject: Re: [PATCH 4.4 038/134] ARM: DRA7: hwmod_data: Prevent
 wait_target_disable error for usb_otg_ss
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20 March 2018 at 15:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Mar 20, 2018 at 07:52:51AM +0800, Dan Rue wrote:
>> On Mon, Mar 19, 2018 at 07:05:21PM +0100, Greg Kroah-Hartman wrote:
>> > 4.4-stable review patch.  If anyone has any objections, please let me know.
>> >
>> > ------------------
>> >
>> > From: Roger Quadros <rogerq@ti.com>
>> >
>> >
>> > [ Upstream commit e2d54fe76997301b49311bde7ba8ef52b47896f9 ]
>> >
>> > It seems that if L3_INIT clkdomain is kept in HW_AUTO while usb_otg_ss
>> > is in use then there are random chances that the usb_otg_ss module
>> > will fail to completely idle. i.e. IDLEST = 0x2 instead of 0x3.
>> >
>> > Preventing L3_INIT from HW_AUTO while usb_otg_ss module is in use
>> > fixes this issue.
>> >
>> > We don't know yet if usb_otg_ss instances 3 and 4 are affected by this
>> > issue or not so don't add this flag for those instances.
>> >
>> > Cc: Tero Kristo <t-kristo@ti.com>
>> > Signed-off-by: Roger Quadros <rogerq@ti.com>
>> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> This fails to build for me on arm32 with default config.
>>
>> #
>> # make -j10 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm multi_v7_defconfig
>> #
>> #
>> # make -j10 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm
>> #
>> ../arch/arm/mach-omap2/omap_hwmod_7xx_data.c:2243:12: error: 'HWMOD_CLKDM_NOAUTO' undeclared here (not in a function)
>>   .flags  = HWMOD_CLKDM_NOAUTO,
>>             ^
>> ../scripts/Makefile.build:269: recipe for target 'arch/arm/mach-omap2/omap_hwmod_7xx_data.o' failed
>> make[2]: *** [arch/arm/mach-omap2/omap_hwmod_7xx_data.o] Error 1
>> make[2]: Target '__build' not remade because of errors.
>> /home/buildslave/workspace/kernel-single-defconfig-builder/defconfig/multi_v7_defconfig/label/builder/Makefile:969: recipe for target 'arch/arm/mach-omap2' failed
>> make[1]: *** [arch/arm/mach-omap2] Error 2
>> make[1]: Target '_all' not remade because of errors.
>> Makefile:152: recipe for target 'sub-make' failed
>> make: *** [sub-make] Error 2
>> make: Target '_all' not remade because of errors.
>
> I've dropped the patch that caused this problem now, will push out a
> -rc2 in a few minutes, thanks.
>

Didn't see that conversation and sent series to fix this problem.
Probably to drop that patch is a better solution. In that case please
just ignore my series.

Thanks!

> greg k-h
