Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C540C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4722521850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeLSDxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:53:48 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.35]:23925 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726600AbeLSDxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 22:53:48 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 8EE3F44A94
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 21:53:47 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZSvbgTmTwiQerZSvbgZOIl; Tue, 18 Dec 2018 21:53:47 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=37510 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZSva-001bn0-01; Tue, 18 Dec 2018 21:53:46 -0600
Subject: Re: [PATCH 00/41] scsi: Mark expected switch fall-throughs
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Khalid Aziz <khalid@gonehiking.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Hannes Reinecke <hare@suse.com>,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        Don Brace <don.brace@microsemi.com>,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Johannes Thumshirn <jth@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Boaz Harrosh <ooo@electrozaur.com>,
        Willem Riede <osst@riede.org>,
        QLogic-Storage-Upstream@qlogic.com,
        =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        esc.storagedev@microsemi.com, megaraidlinux.pdl@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, osst-users@lists.sourceforge.net,
        xen-devel@lists.xenproject.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <304623b0-e0ad-ec9c-7097-c6f00ba43948@embeddedor.com>
 <yq1mup2i3h1.fsf@oracle.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <ab57e784-9471-a707-0fe6-b12b0cb027f3@embeddedor.com>
Date:   Tue, 18 Dec 2018 21:53:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <yq1mup2i3h1.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gZSva-001bn0-01
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.106.44]:37510
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 48
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/18/18 9:45 PM, Martin K. Petersen wrote:
> 
> If you haven't received feedback on a patch you should poke the relevant
> driver maintainer.
> 

Got it. Will do so.

Thanks
--
Gustavo
