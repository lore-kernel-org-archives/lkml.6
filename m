Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EA8C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5256920863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfBAJCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:02:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726092AbfBAJCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:02:08 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x118wgqj057901
        for <linux-kernel@vger.kernel.org>; Fri, 1 Feb 2019 04:02:07 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qcj663065-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:02:06 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 1 Feb 2019 09:02:05 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Feb 2019 09:02:03 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x11921sS46858354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Feb 2019 09:02:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 774B3A405F;
        Fri,  1 Feb 2019 09:02:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 208D7A405C;
        Fri,  1 Feb 2019 09:02:01 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Feb 2019 09:02:01 +0000 (GMT)
Date:   Fri, 1 Feb 2019 10:01:59 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Sebastian Ott <sebott@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <alpine.LFD.2.21.1901301912380.2372@schleppi>
 <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19020109-0016-0000-0000-0000024F31CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020109-0017-0000-0000-000032A933A2
Message-Id: <20190201090159.GC3770@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902010068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 06:28:39PM -0500, Tony Krowiak wrote:
> On 1/30/19 1:32 PM, Sebastian Ott wrote:
> >On Wed, 30 Jan 2019, Tony Krowiak wrote:
> >>+#if IS_ENABLED(CONFIG_ZCRYPT)
> >>+void ap_bus_cfg_chg(void);
> >>+#else
> >>+#error "no CONFIG_ZCRYPT"
> >    ^
> >I don't think that's the right thing to do here.
> 
> I'd like to leave it. If somebody edits .config
> and sets CONFIG_ZCRYPT=n, then the build will
> fail. The preprocessor error above tells them
> why.

No, the kernel build should never fail if a config option is not set.
Also the above should be "#ifdef CONFIG_ZCRYPT".

In addition (this isn't quoted unfortunately) the alternative function
in the header file is missing the "inline" attribute. Can you please
add that too?

static inline void ap_bus_cfg_chg(void) { }

> >>+* A config change has happened, Force an ap bus rescan.
> >>+*/
> >>+void ap_bus_cfg_chg(void)
> >>+{
> >>+	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
> >>+
> >>+	ap_bus_force_rescan();
> >>+}
> >>+EXPORT_SYMBOL(ap_bus_cfg_chg);
> >
> >There is no need for the export symbol - you don't call that function
> >from module code.
> >As an unrelated question, just to be sure: ap_bus.c is compiled as
> >built-in even with ZCRYPT=m, right?
> 
> No. If you edit .config and set CONFIG_ZCRYPT=m, ap_bus.c will be built
> into the zcrypt.ko module. Through some other magic, the zcrypt module
> is loaded when linux boots.

If that happens, then we have a build problem that needs to be
fixed. What exactly are you doing to get the ap code linked into the
zcrypt module?

