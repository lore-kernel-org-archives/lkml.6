Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B498C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5145421900
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfBALIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:08:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729721AbfBALIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:08:30 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x11B47mO063760
        for <linux-kernel@vger.kernel.org>; Fri, 1 Feb 2019 06:08:28 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qcjek0f69-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 06:08:28 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 1 Feb 2019 11:08:26 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Feb 2019 11:08:25 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x11B8NQj66256920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Feb 2019 11:08:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7443542047;
        Fri,  1 Feb 2019 11:08:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22D0A4203F;
        Fri,  1 Feb 2019 11:08:23 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.164])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Feb 2019 11:08:23 +0000 (GMT)
Date:   Fri, 1 Feb 2019 12:08:22 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI
 command
In-Reply-To: <20190201090159.GC3770@osiris>
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
        <alpine.LFD.2.21.1901301912380.2372@schleppi>
        <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
        <20190201090159.GC3770@osiris>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19020111-4275-0000-0000-00000308D086
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020111-4276-0000-0000-00003816DE1B
Message-Id: <20190201120822.41d39ddb@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902010083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 10:01:59 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Thu, Jan 31, 2019 at 06:28:39PM -0500, Tony Krowiak wrote:
> > On 1/30/19 1:32 PM, Sebastian Ott wrote:  
> > >On Wed, 30 Jan 2019, Tony Krowiak wrote:  
> > >>+#if IS_ENABLED(CONFIG_ZCRYPT)
> > >>+void ap_bus_cfg_chg(void);
> > >>+#else
> > >>+#error "no CONFIG_ZCRYPT"  
> > >    ^
> > >I don't think that's the right thing to do here.  
> > 
> > I'd like to leave it. If somebody edits .config
> > and sets CONFIG_ZCRYPT=n, then the build will
> > fail. The preprocessor error above tells them
> > why.  
> 
> No, the kernel build should never fail if a config option is not set.
> Also the above should be "#ifdef CONFIG_ZCRYPT".
> 
> In addition (this isn't quoted unfortunately) the alternative function
> in the header file is missing the "inline" attribute. Can you please
> add that too?
> 
> static inline void ap_bus_cfg_chg(void) { }
> 
> > >>+* A config change has happened, Force an ap bus rescan.
> > >>+*/
> > >>+void ap_bus_cfg_chg(void)
> > >>+{
> > >>+	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
> > >>+
> > >>+	ap_bus_force_rescan();
> > >>+}
> > >>+EXPORT_SYMBOL(ap_bus_cfg_chg);  
> > >
> > >There is no need for the export symbol - you don't call that function
> > >from module code.
> > >As an unrelated question, just to be sure: ap_bus.c is compiled as
> > >built-in even with ZCRYPT=m, right?  
> > 
> > No. If you edit .config and set CONFIG_ZCRYPT=m, ap_bus.c will be built
> > into the zcrypt.ko module. Through some other magic, the zcrypt module
> > is loaded when linux boots.  
> 
> If that happens, then we have a build problem that needs to be
> fixed. What exactly are you doing to get the ap code linked into the
> zcrypt module?

Current upstream code:

ap-objs := ap_bus.o ap_card.o ap_queue.o
obj-$(subst m,y,$(CONFIG_ZCRYPT)) += ap.o

The ap_bus.o file is either not build at all or it is linked into the
main kernel image. If ap_bus.o is build then it is guaranteed that
CONFIG_ZCRYPT is either "m" or "y".

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

