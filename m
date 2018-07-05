Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745EAC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174882418D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="cuv/vYhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174882418D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeGEJ5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:57:38 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39754 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbeGEJ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:57:36 -0400
Received: by mail-it0-f65.google.com with SMTP id p185-v6so11510267itp.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SK3GNceKbuCLpLCvIxGOF8u8siznIciBHVldSWBrRN8=;
        b=cuv/vYhljzXWmQ7NNI/11QHCpZ9yK9VEhkVvcWcw7rfoAhW0wRpX9AFEooDVwBf3BC
         yZhl0B9W2EzGJ9VemuZQpwHmGefgw9JDdyuzk2IQ3OcEFzbgWmnJ9TSUTysZAQ/4geRL
         N0kCQrTMSQnux7xjDeTaNCmz/aKtgdJJXelpJcSb5X9N5gr6ONUoBY2SaM7KNBIlUHpu
         CW0OGXkoDMZggReCnjOMff5etchf/B3qohS63m+0pv1QoxHfgr+UFA7+GDotG/VOra8E
         7Gk/I+8wmuTKBETUvzibcTBigmSfgKD+5HrlPm7FCLIYqYAArhRYD197NZN7Be51DWF3
         o71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SK3GNceKbuCLpLCvIxGOF8u8siznIciBHVldSWBrRN8=;
        b=j2IkHQo5fvARWKpF5V3UXhgIm0sLa/iSXvyb2mr5UWzBpMYOvE/C2sSB3kBhCrRqjO
         jmbTSjrqu7v/EIzX8JlALVouDMfqD0w04ymDLUk1o8UPG8A+x2CFMwjO2m0+VzKeYi75
         azfDw2LNQ6frNIcaVDHlhvedbmzniE9dT/QYCj7g8oD3y95+02wEtQ4Rx6SE2giPTvkt
         p8mK0RloO52F/Aj8KwhCqKDeHxyknNXx6HIgM6cRCbndZNSiWJz+ZxQeYsGN5oybXRlt
         G/IFHwkKfnaXxx3msbugTdzKZovnxhd+JgcOKNMI8mD4od8tOix2JZx98jX+O3qQiCIc
         mhVA==
X-Gm-Message-State: APt69E34Bc4p3jGa/grfFwdi2PVMTRZcrXjuYjO6FNrky8NWBH2b54oE
        RpsrYva5oFw+Zgoc/BlWKMJ6BBRdFbgQx3kt6ZBQaw==
X-Google-Smtp-Source: AAOMgpeeO6qcWLe6+19z4BurcHp/svDGe22pu1tblkNdFRfGkS8nRrwJbp+ao1Me9oY+n8fu79/sI/GgCKPYm2w2Bys=
X-Received: by 2002:a24:95c6:: with SMTP id m189-v6mr4048839itd.87.1530784655262;
 Thu, 05 Jul 2018 02:57:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7391:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 02:57:34 -0700 (PDT)
In-Reply-To: <20180705093230.byqbk6f5ornezmka@mwanda>
References: <CAPpJ_ed1oFQW_xmBtetP-ztoL7Z14T6akOSgKJ_8jxogdf3FWg@mail.gmail.com>
 <f3bf0687-76fb-9411-6fa2-e8ef312efb58@lwfinger.net> <20180704140933.3dk2ylbntltz6jqd@mwanda>
 <7e95bd6a-97bc-b030-26ce-83da66e5f279@lwfinger.net> <CAD8Lp44EG73XQ9omQhH6XiHfm2rMypmndSFyffnf_PVMueTvEA@mail.gmail.com>
 <1530776154.4156.12.camel@realtek.com> <CAPpJ_ecCzhxEu8gMBFRsCerpeu_Z8TR=Rw5BiFhzVYP6WK-wAw@mail.gmail.com>
 <20180705093230.byqbk6f5ornezmka@mwanda>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Thu, 5 Jul 2018 17:57:34 +0800
Message-ID: <CAPpJ_ef8At7dWZwByPYvOX56930LXtXRFLpkxjmb_+jVGLLb5w@mail.gmail.com>
Subject: Re: [BUG] staging: r8822be: RTL8822be can't find any wireless AP
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Pkshih <pkshih@realtek.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Tony Chuang <yhchuang@realtek.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Steven Ting <steventing@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Birming Chiu <birming@realtek.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "sgruszka@redhat.com" <sgruszka@redhat.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "frank@generalsoftwareinc.com" <frank@generalsoftwareinc.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux@endlessm.com" <linux@endlessm.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-05 17:32 GMT+08:00 Dan Carpenter <dan.carpenter@oracle.com>:
> On Thu, Jul 05, 2018 at 05:26:28PM +0800, Jian-Hong Pan wrote:
>> 2018-07-05 15:36 GMT+08:00 Pkshih <pkshih@realtek.com>:
>> > On Wed, 2018-07-04 at 10:33 -0500, Daniel Drake wrote:
>> >> On Wed, Jul 4, 2018 at 10:13 AM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>> >> > We will have to agree to disagree.
>> >> >
>> >> > I have no idea what the vendors are doing that cause some motherboards to
>> >> > need a different aspm value. What I do know is that we have had to live with
>> >> > the idiocy of some vendors saving a few pennies by only including a single
>> >> > antenna, rather than two, and then making a problem by miscoding the EFUSE
>> >> > bit that indicates which connector is actually in use. As we have no means
>> >> > that I know about to detect which boxes have the problem, a module parameter
>> >> > was created, just as in this case.
>> >> >
>> >> > I agree that drivers should work "out of the box", but finite resources and
>> >> > lack of vendor cooperation make this a goal that may not be attainable.
>> >>
>> >> As you touched on, the ideal situation is that Realtek solve the
>> >> issue. Ping-Ke Shih is on CC and I am adding a few more contacts from
>> >> the commit log. The context is that the r8822 driver fails on several
>> >> platforms unless setting aspm=0 (the default is 1).
>> >
>> > It's hard to have all laptop or motherboards and all rtl8822be modules in my side,
>> > so what I can do is to analyze the issue when user encountered.
>> >
>> >>
>> >> https://gist.github.com/dsd/20c05f0c6d66ee2ef9bfbb17f93f18ba
>> >> https://bugzilla.kernel.org/show_bug.cgi?id=199651
>> >>
>> >>
>> >> If we don't get a timely fix from Realtek though, I think there is a
>> >> key difference between the antenna selection headache and this one. In
>> >> the antenna case, there isn't a good value that you can set that will
>> >> work on all systems. If you change the default behaviour you will
>> >> solve the issue for some users while simultanously introducing the
>> >> problem on other systems that were previously fine.
>> >>
>> >> However in this case, it's highly likely that setting aspm=0 (off) by
>> >> default would work for everyone. It has the disadvantage of using a
>> >> bit more power, but especially with the indications that this issue
>> >> affects a significant number of systems, I think that having the
>> >> driver working out of the box everywhere is more important. The module
>> >> parameter can be left in place so that unaffected users that want to
>> >> save power can set aspm=1.
>> >>
>> >
>> > I think this issue may be due to L1 latency, so below patch would be
>> > helpful but not sure because I don't have the same laptop.
>> > Is there anyone can help to test?
>>
>> I do not know why I cannot apply this patch directly.  So, I apply
>> each line manually.
>>
>> However, here is a good news.  I tested this fix, and it works
>> correctly on ASUS X530UN.  System can scan and get the access points
>> list.  Finally, it also connects to the access point.
>> Maybe, you can have a formal patch for this.
>>
>
> That's good news.  What does the "dmesg | grep r8822be" say now?

dev@endless:~/linux-eos$ dmesg | grep r8822be
[    8.538404] r8822be: module is from the staging directory, the
quality is unknown, you have been warned.
[    8.541706] r8822be 0000:02:00.0: enabling device (0000 -> 0003)
[    8.571568] r8822be: Using firmware rtlwifi/rtl8822befw.bin
[    8.572370] r8822be: rtlwifi: wireless switch is on
[    8.573338] r8822be 0000:02:00.0 wlp2s0: renamed from wlan0
[   11.346560] Modules linked in: nouveau(+) snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel mxm_wmi
snd_hda_codec r8822be(C) x86_pkg_temp_thermal snd_hwdep snd_hda_core
efivarfs i915

The warning message comes from nouveau.  That is no matter.

Here is the full dmesg
https://gist.github.com/starnight/29b1ead5659868fcfb7f172e51a96535#file-gistfile1-txt

Regards,
Jian-Hong Pan
