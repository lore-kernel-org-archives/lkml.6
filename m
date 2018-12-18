Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF1FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B55321852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeLRPoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:44:08 -0500
Received: from gateway30.websitewelcome.com ([192.185.146.7]:16422 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbeLRPoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:44:07 -0500
X-Greylist: delayed 1205 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Dec 2018 10:44:06 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id E5F24EEA23E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 09:24:00 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZHE0gP32HdnCeZHE0gZ6Yd; Tue, 18 Dec 2018 09:24:00 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=42068 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZHDy-0001E3-UF; Tue, 18 Dec 2018 09:23:59 -0600
Subject: Re: [PATCH 00/41] scsi: Mark expected switch fall-throughs
To:     Khalid Aziz <khalid@gonehiking.org>,
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
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <cover.1543374820.git.gustavo@embeddedor.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <304623b0-e0ad-ec9c-7097-c6f00ba43948@embeddedor.com>
Date:   Tue, 18 Dec 2018 09:23:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cover.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gZHDy-0001E3-UF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:42068
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 41
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Friendly ping:

Only 8 out the 41 patches in this series have been applied so far.

I wonder if you could apply the rest of this series, except:

  [PATCH 02/41] scsi: NCR5380: Mark expected switch fall-through

(I'll send a v2 of this patch)

Thanks
--
Gustavo

On 11/27/18 10:18 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, this patchset aims
> to mark switch cases where we are expecting to fall through.
> 
> I reviewed case by case and concluded that each of them is an
> intentional fall-through. However, it doesn't hurt that the
> maintainers and supporters of each driver take a look. :)
> 
> Each commit log contains the particular details for the changes in the
> corresponding file.
> 
> This series fix a total of 110 of the following type of warnings in
> drivers/scsi:
> 
> drivers/scsi/aic7xxx/aic7xxx_core.c:4921:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     ahc_dma_tag_destroy(ahc, scb_data->sg_dmat);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/aic7xxx/aic7xxx_core.c:4923:2: note: here
>    case 6:
>    ^~~~
> 
> Thanks!
> 
> Gustavo A. R. Silva (41):
>    scsi: BusLogic: mark expected switch fall-through
>    scsi: NCR5380: Mark expected switch fall-through
>    scsi: aacraid: aachba: Mark expected switch fall-throughs
>    scsi: aacraid: linit: Mark expected switch fall-through
>    scsi: aic7xxx: aic79xx: mark expected switch fall-through
>    scsi: aic7xxx: mark expected switch fall-throughs
>    scsi: be2iscsi: be_iscsi: Mark expected switch fall-through
>    scsi: be2iscsi: be_main: Mark expected switch fall-through
>    scsi: bfa: bfa_fcpim: Mark expected switch fall-throughs
>    scsi: bfa: bfa_fcs_lport: Mark expected switch fall-throughs
>    scsi: bfa: bfa_fcs_rport: Mark expected switch fall-throughs
>    scsi: bfa: bfa_ioc: Mark expected switch fall-throughs
>    scsi: csiostor: csio_wr: mark expected switch fall-through
>    scsi: esas2r: esas2r_init: mark expected switch fall-throughs
>    scsi: hpsa: mark expected switch fall-throughs
>    scsi: imm: mark expected switch fall-throughs
>    scsi: isci: phy: Mark expected switch fall-through
>    scsi: isci: remote_device: Mark expected switch fall-throughs
>    scsi: isci: remote_node_context: mark expected switch fall-throughs
>    scsi: isci: request: mark expected switch fall-through
>    scsi: libfc: fc_rport: Mark expected switch fall-through
>    scsi: lpfc: lpfc_ct: Mark expected switch fall-throughs
>    scsi: lpfc: lpfc_els: Mark expected switch fall-throughs
>    scsi: lpfc: lpfc_hbadisc: Mark expected switch fall-throughs
>    scsi: lpfc: lpfc_nportdisc: Mark expected switch fall-through
>    scsi: lpfc: lpfc_nvme: Mark expected switch fall-through
>    scsi: lpfc: lpfc_scsi: Mark expected switch fall-throughs
>    scsi: lpfc: lpfc_sli: Mark expected switch fall-throughs
>    scsi: megaraid: megaraid_sas_base: Mark expected switch fall-through
>    scsi: megaraid_sas_fusion: Mark expected switch fall-through
>    scsi: mpt3sas: mpt3sas_scsih: Mark expected switch fall-through
>    scsi: myrb: Mark expected switch fall-throughs
>    scsi: osd: osd_initiator: mark expected switch fall-throughs
>    scsi: osst: mark expected switch fall-throughs
>    scsi: ppa: mark expected switch fall-through
>    scsi: qla4xxx: ql4_os: mark expected switch fall-through
>    scsi: st: mark expected switch fall-throughs
>    scsi: sym53c8xx_2: sym_hipd: mark expected switch fall-throughs
>    scsi: sym53c8xx_2: sym_nvram: Mark expected switch fall-through
>    scsi: ufs: ufshcd: mark expected switch fall-throughs
>    scsi: xen-scsifront: mark expected switch fall-through
> 
>   drivers/scsi/BusLogic.c                     |  1 +
>   drivers/scsi/NCR5380.c                      |  3 +-
>   drivers/scsi/aacraid/aachba.c               |  5 +++-
>   drivers/scsi/aacraid/linit.c                |  1 +
>   drivers/scsi/aic7xxx/aic79xx_core.c         | 14 +++++----
>   drivers/scsi/aic7xxx/aic7xxx_core.c         | 12 ++++++--
>   drivers/scsi/be2iscsi/be_iscsi.c            |  1 +
>   drivers/scsi/be2iscsi/be_main.c             |  1 +
>   drivers/scsi/bfa/bfa_fcpim.c                |  6 ++--
>   drivers/scsi/bfa/bfa_fcs_lport.c            |  8 ++---
>   drivers/scsi/bfa/bfa_fcs_rport.c            | 19 +++++-------
>   drivers/scsi/bfa/bfa_ioc.c                  |  9 ++----
>   drivers/scsi/csiostor/csio_wr.c             |  1 +
>   drivers/scsi/esas2r/esas2r_init.c           |  3 +-
>   drivers/scsi/hpsa.c                         |  5 ++++
>   drivers/scsi/imm.c                          | 33 +++++++++++----------
>   drivers/scsi/isci/phy.c                     |  1 +
>   drivers/scsi/isci/remote_device.c           |  4 +--
>   drivers/scsi/isci/remote_node_context.c     |  4 +--
>   drivers/scsi/isci/request.c                 |  2 +-
>   drivers/scsi/libfc/fc_rport.c               |  1 +
>   drivers/scsi/lpfc/lpfc_ct.c                 |  2 ++
>   drivers/scsi/lpfc/lpfc_els.c                |  1 +
>   drivers/scsi/lpfc/lpfc_hbadisc.c            |  4 ++-
>   drivers/scsi/lpfc/lpfc_nportdisc.c          |  1 +
>   drivers/scsi/lpfc/lpfc_nvme.c               |  1 +
>   drivers/scsi/lpfc/lpfc_scsi.c               |  8 ++---
>   drivers/scsi/lpfc/lpfc_sli.c                | 20 +++++++------
>   drivers/scsi/megaraid/megaraid_sas_base.c   |  1 +
>   drivers/scsi/megaraid/megaraid_sas_fusion.c |  2 +-
>   drivers/scsi/mpt3sas/mpt3sas_scsih.c        |  1 +
>   drivers/scsi/myrb.c                         |  3 ++
>   drivers/scsi/osd/osd_initiator.c            |  3 +-
>   drivers/scsi/osst.c                         |  6 ++++
>   drivers/scsi/ppa.c                          |  1 +
>   drivers/scsi/qla4xxx/ql4_os.c               |  2 +-
>   drivers/scsi/st.c                           |  4 +++
>   drivers/scsi/sym53c8xx_2/sym_hipd.c         |  2 ++
>   drivers/scsi/sym53c8xx_2/sym_nvram.c        |  1 +
>   drivers/scsi/ufs/ufshcd.c                   |  3 ++
>   drivers/scsi/xen-scsifront.c                |  2 +-
>   41 files changed, 124 insertions(+), 78 deletions(-)
> 
