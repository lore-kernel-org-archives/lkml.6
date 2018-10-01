Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6681C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A262A2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A262A2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbeJAUGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:06:51 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48017 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729182AbeJAUGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:06:50 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w91DOVnN023089;
        Mon, 1 Oct 2018 15:28:40 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mu1bjmbkd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Oct 2018 15:28:40 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ABBB63F;
        Mon,  1 Oct 2018 13:28:39 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 46B1E4543;
        Mon,  1 Oct 2018 13:28:39 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.46) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 1 Oct
 2018 15:28:38 +0200
Subject: Re: [RESEND PATCH] Revert "pwm: Set class for exported channels in
 sysfs"
To:     Gottfried Haider <gottfried.haider@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <stefan.wahren@i2se.com>, <gohai@sukzessiv.net>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        <loic.pallardy@st.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <michal.vokac@ysoft.com>
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
 <20180924115301.GV21032@ulmo> <fc02ced1-01ba-dde4-95da-285d9351338b@st.com>
 <20180924142318.GG23547@ulmo> <c4866533-1c7e-2675-5d80-3b824e32ae9b@st.com>
 <4278fef9-ec60-239a-dd0a-29a89d742fa4@st.com> <20180925152022.GB27695@ulmo>
 <CAPoCmY+mNYSV8gq7VCcSJHDpmoq-i7SDJ6uQ5VbLpMZB=b0waQ@mail.gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <a6589b2d-c9b3-88a3-f764-e8519db09dbc@st.com>
Date:   Mon, 1 Oct 2018 15:28:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPoCmY+mNYSV8gq7VCcSJHDpmoq-i7SDJ6uQ5VbLpMZB=b0waQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/29/2018 02:19 AM, Gottfried Haider wrote:
> Hello Thierry & Fabrice,
> 
>>> Still, it is possible to send uevent (KOBJ_CHANGE) on pwmchipN device,
>>> to notify of a change, e.g. pwmX channel being exported/unexported.
> 
> I tested this patch, and I am happy to report that it works with the
> udev rule that Raspbian (Raspberry Pi's Debian derivative) has in
> place:
> 
> SUBSYSTEM=="pwm*", PROGRAM="/bin/sh -c '\
>         chown -R root:gpio /sys/class/pwm && chmod -R 770 /sys/class/pwm;\
>         chown -R root:gpio
> /sys/devices/platform/soc/*.pwm/pwm/pwmchip* && chmod -R 770
> /sys/devices/platform/soc/*.pwm/pwm/pwmchip*\
> '"
> 
> 
> So while I can't comment on the uevent semantics, it would solve what
> the original patch attempted to enable (non-root use of pwm).
> 
> Tested-by: Gottfried Haider <gottfried.haider@gmail.com>

Hi Gottfried, Thierry,

Thanks for testing. I just sent a new series with:
- revert patch
- additional patch with proposed uevent notification (change) on pwmchip.

Best Regards,
Fabrice

> 
> Best,
> Gottfried
> 
