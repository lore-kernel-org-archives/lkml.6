Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8C8C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2092184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfAXHIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:08:49 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:57386 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbfAXHIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:08:49 -0500
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0O76rG1001438;
        Thu, 24 Jan 2019 01:08:47 -0600
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2q6qjub1ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jan 2019 01:08:47 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (us-aus-exhub2.ni.corp.natinst.com [130.164.68.32])
        by us-aus-skprod2.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x0O78kuZ024716
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Jan 2019 01:08:46 -0600
Received: from us-aus-exch5.ni.corp.natinst.com (130.164.68.15) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 24 Jan 2019 01:08:46 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch5.ni.corp.natinst.com (130.164.68.15) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 24 Jan 2019 01:08:46 -0600
Received: from my-pen-rd24.apac.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Thu, 24 Jan 2019 01:08:44 -0600
From:   Guan Yung Tseng <guan.yung.tseng@ni.com>
To:     <andy.shevchenko@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Guan Yung Tseng <guan.yung.tseng@ni.com>
Subject: [PATCH] 8250_pci.c: Update NI specific devices class to multi serial
Date:   Thu, 24 Jan 2019 15:07:47 +0800
Message-ID: <1548313667-125014-1-git-send-email-guan.yung.tseng@ni.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jan 23, 2019 at 5:18 PM Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Jan 14, 2019 at 4:13 PM Guan Yung Tseng <guan.yung.tseng@ni.com> wrote:
> > >
> > > Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
> > > The reason of doing this is because all NI multi port serial cards 
> > > use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the 
> > > serial_pci_is_class_communication test added in the commit 
> > > 7d8905d06405
> > > ("serial: 8250_pci: Enable device after we check black list").
> >
> > Guan, can you provide an output of the
> >
> > lspci -nk -xx -vv -s <BDF>
> >
> > of your device, where <BDF> is a PCI address in a form of bus:device.function?
>

Output of lspci before applied the patch

admin@NI-PXIe-8840Quad-Core-0308D657:~# lspci -nk -xx -vv -s 0d:0e.0
0d:0e.0 0780: 1093:70e8
        Subsystem: 1093:70e8
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping
- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <M
Abort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fe201000 (32-bit, non-prefetchable) [disabled] [size=4K]
00: 93 10 e8 70 40 01 80 02 00 00 80 07 10 20 00 00
10: 00 10 20 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 93 10 e8 70
30: 00 00 00 00 f0 00 00 00 00 00 00 00 0a 01 00 00

admin@NI-PXIe-8840Quad-Core-0308D657:~# lspci -nk -xx -vv -s 0d:0f.0
0d:0f.0 0780: 1093:70ec
        Subsystem: 1093:70ec
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping
- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <M
Abort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fe200000 (32-bit, non-prefetchable) [disabled] [size=4K]
00: 93 10 ec 70 40 01 80 02 00 00 80 07 10 20 00 00
10: 00 00 20 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 93 10 ec 70
30: 00 00 00 00 f0 00 00 00 00 00 00 00 0b 01 00 00

> While I'm still wondering of the above, can you also test the bellow patch if it fixes your issue?

The patch fixes the issue. The devices bind to the serial kernel driver successfully.
Below is the output of lspci -nk -xx -vv -s <BDF> for the same devices after I applied the patch.

admin@NI-PXIe-8840Quad-Core-0308D657:~# lspci -nk -xx -vv -s 0d:0e.0
0d:0e.0 0780: 1093:70e8
        Subsystem: 1093:70e8
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping
- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <M
Abort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at fe201000 (32-bit, non-prefetchable) [size=4K]
        Kernel driver in use: serial
00: 93 10 e8 70 42 01 80 02 00 00 80 07 10 20 00 00
10: 00 10 20 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 93 10 e8 70
30: 00 00 00 00 f0 00 00 00 00 00 00 00 0a 01 00 00

admin@NI-PXIe-8840Quad-Core-0308D657:~# lspci -nk -xx -vv -s 0d:0f.0
0d:0f.0 0780: 1093:70ec
        Subsystem: 1093:70ec
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping
- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <M
Abort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at fe200000 (32-bit, non-prefetchable) [size=4K]
        Kernel driver in use: serial
00: 93 10 ec 70 42 01 80 02 00 00 80 07 10 20 00 00
10: 00 00 20 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 93 10 ec 70
30: 00 00 00 00 f0 00 00 00 00 00 00 00 0b 01 00 00

