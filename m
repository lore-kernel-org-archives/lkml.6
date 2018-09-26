Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06B8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7918C20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7918C20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kpanic.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIZUtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:49:02 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36869 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeIZUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:49:01 -0400
Received: from t530.fritz.box ([217.83.97.120]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N7gfa-1fiZtA1Plq-014oLq; Wed, 26 Sep 2018 16:34:50 +0200
Date:   Wed, 26 Sep 2018 16:34:49 +0200
From:   Stefan Assmann <sassmann@kpanic.de>
To:     Alexander Kappner <agk@godking.net>
Cc:     ibm-acpi@hmh.eng.br, dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Second Fan Support for Thinkpad P50
Message-ID: <20180926143449.bnqliemloqw7fuyv@t530.fritz.box>
References: <1522693621-3124-1-git-send-email-agk@godking.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522693621-3124-1-git-send-email-agk@godking.net>
User-Agent: NeoMutt/20180716
X-Provags-ID: V03:K1:8M444cONRvg2IiEFr+OJ0WILOwRlw9zj1cTZLNNPaORVh7Pyv79
 x/H/kJK9488FysdEutoai0haEqelHe2E+olp640NqadEwOdFi2IcH4NPxlDkZ40ZtTFYj6j
 5+2MvgssF9WPDLOKcurvceVVgLP8oWuNGpcv15GS+rwXak7k4SpeQlXUEeudEVnzpCQFVsq
 3ovIm2IpvU5iejLC6B09w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WpW4SoZ9yFo=:uzZ14MmnjIS26EUrIcpcVS
 vYXRC29GGMjAC8RyxO8y5b6AJh2pkbfe1RvoOFD9Coxyl5tu7sigZnyUZ8BURwJIM2sEf9RS4
 Og26DSNtGGo5a2PAx82PFS19JCU5b+eLlWTZn6vdFfCpICnqoXzdYw+4gQoXVD6YgYKO/2UGn
 tvk31A62GLrH7LpSTLl+sFIU1qk/gyl2CdZhKUOCGD+grp8H7XL1wLLcy5bZmXYouB4ONhCjo
 NPJeJPngU2RNsCQX3p17knRM41eWbMLvfv1Sn5RThAetgkNRgvOCIjlPUXAch+4OKB61QG9ER
 6DkAC1wBz+8n4aqymYyMgPVqJ2MTW/u6qXkQGnb/Xo6lX32LoXSiu1Bm/YbOo633m0uIF9UqJ
 BPfU4jYZlE6ihL7f3XPqZ7OIfEXFoxyhuTaLOMhTE6jQetH8ikxFNgBG0I9YyFs5Ezu3aqYUR
 J2j2K0bEg85rWSRtJPPtTFtVqvp8u4P8Pkj6YNfxr+kNi0o341faUD87Si4fSExIFLbIR6tcs
 vkkXWvqehxHs4T24flxVxNZ7eRE7oR7QWshV/Hgk4XvV9013x3zcqR0NMuoFJKRlOpCLz65QI
 NWc6DnLYV7bLdZ8N5nQIpRPjqaNBYP5Zi9J1YrJwD+N+zfO++nU8HY2WqH8Uqa3NNH6s58+KX
 nwxXYia828vFV++fDDJXifR5V/aYJHeNrxTLqD54Q04Wf7XvzywZfYCDLmUaw7ZHRzJY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-02 11:27, Alexander Kappner wrote:
> The Thinkpad P50 has 2 fans. Add the 2FAN quirk so the tpacpi driver
> properly reports both fan speeds.
> Because the P50 doesn't report the version of its EC controller, we need to
> identify it by BIOS version (N1).

With 4.18 (including this patch) I'm seeing both fans on my P50.
[root@p50 ~]# sensors
[...]
thinkpad-isa-0000
Adapter: ISA adapter
fan1:        2319 RPM
fan2:        2323 RPM

Is there a way to actually control the second fan? There's pwm1, but no
pwm2. And pwm1 only affects fan1.

[root@p50 ~]# ls -al /sys/devices/platform/thinkpad_hwmon/hwmon/hwmon3/
total 0
drwxr-xr-x 3 root root    0 Sep 26 16:25 .
drwxr-xr-x 3 root root    0 Sep 26 16:23 ..
lrwxrwxrwx 1 root root    0 Sep 25 16:11 device -> ../../../thinkpad_hwmon
-r--r--r-- 1 root root 4096 Sep 25 16:11 fan1_input
-r--r--r-- 1 root root 4096 Sep 25 16:11 fan2_input
-r--r--r-- 1 root root 4096 Sep 25 16:11 name
drwxr-xr-x 2 root root    0 Sep 26 15:57 power
-rw-r--r-- 1 root root 4096 Sep 26 16:25 pwm1
-rw-r--r-- 1 root root 4096 Sep 26 16:25 pwm1_enable
lrwxrwxrwx 1 root root    0 Sep 25 16:11 subsystem -> ../../../../../class/hwmon
-rw-r--r-- 1 root root 4096 Sep 25 16:11 uevent

[root@p50 ~]# echo 2 > /sys/devices/platform/thinkpad_hwmon/hwmon/hwmon3/pwm1_enable
[root@p50 ~]# sensors
[...]
thinkpad-isa-0000
Adapter: ISA adapter
fan1:        3042 RPM
fan2:        2323 RPM

Thanks!

  Stefan


> Signed-off-by: Alexander Kappner <agk@godking.net>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index d5eaf3b1..ebdc300 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8699,16 +8699,24 @@ static const struct attribute_group fan_attr_group = {
>  	  .ec = TPID(__id1, __id2),		\
>  	  .quirks = __quirks }
>  
> +#define TPACPI_FAN_QL_BIOS(__id1, __id2, __quirks)	\
> +	{ .vendor = PCI_VENDOR_ID_LENOVO,	\
> +	  .bios = TPID(__id1, __id2),		\
> +	  .ec = TPACPI_MATCH_ANY,		\
> +	  .quirks = __quirks }
> +
>  static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>  	TPACPI_FAN_QI('1', 'Y', TPACPI_FAN_Q1),
>  	TPACPI_FAN_QI('7', '8', TPACPI_FAN_Q1),
>  	TPACPI_FAN_QI('7', '6', TPACPI_FAN_Q1),
>  	TPACPI_FAN_QI('7', '0', TPACPI_FAN_Q1),
>  	TPACPI_FAN_QL('7', 'M', TPACPI_FAN_2FAN),
> +	TPACPI_FAN_QL_BIOS('N', '1', TPACPI_FAN_2FAN) // Thinkpad P50 has 2 fans
>  };
>  
>  #undef TPACPI_FAN_QL
>  #undef TPACPI_FAN_QI
> +#undef TPACPI_FAN_QL_BIOS
>  
>  static int __init fan_init(struct ibm_init_struct *iibm)
>  {
> -- 
> 2.1.4
> 
> 
