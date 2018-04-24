Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2307271-1524543407-2-15679664580434222482
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524543406; b=uZV5UXAviDq1nb0FKJiNXw24pMp3QXvojPohtzyh16ZriTGnSX
    5jDEe0/lw7wAygkKZS8e8sQbnqJv0JmsQLib/8vezySveJTl9i0E/fEXEywpeMeF
    NDKFeo7Na4Kj5VLBZk9xjBwGiJZ37/UjWB88Lvy8mwJbuOwIUs7kibeB+p9/3cdF
    swycl6XBBMzNBMBck2rV9WCatubC5SnVkPUwJnHV7KHP6YzmlPv7Dyn9yAu7j5Y5
    3Yujc/PslIRR2A+GkDqqDVhLeBge9XTEQlj5rVtvZMGvBYeZT03YXQd9gBjNPHbu
    3TqxM0lkR3wnMtZkInm2oLbvTTb7qgHsW/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524543406;
    bh=1TLVLsmhOQjWCU5uci0tTybeb9hMLFDU3Iev+4igPaE=; b=RxcAm7Qi8h7j
    WctAsqbh5YEdED31pyVOH4ciSlNK9IQVBM272whNPuTKRS7q+2a1l9aj18Fxjhog
    VqDGvfw+FQ5NV5KSt1CFsAaHCbksZYgRMTfODWALME4Ej2hiAgzAkyiVxOThSBag
    tsiSEcur5UkZM9FEKtCUiia4lsCcPw7gSw30cIWi2xYHHWQnI5J0rSEvfsqVEVkY
    SXN/N2+x0SxvxCHRktbou9BZupVKzpdC8pgTcxIduKB15TIntS3i1nHxXcCUFsWr
    dq8mKHf55XuLA4vGrW6Sby4EAOUeNwnt+Yc+ywxdh42jtD1QDhbjwe+fbCEAtOCO
    VUEk/sFsIQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=marvell.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=marvell.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=marvell.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=marvell.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGSXqRhx+VgU8Ld97Q7WLj6k0XJydnyqyJmlnWlfJQSqkUqPifd7cddxQwAISFPoQQjeakpiutueS4VJQVCvzOI+vvdC/v45Z3Sgf8WbKpZ38RECN3kH
    EksFRw3P5unxvgNfggB5Ztx3ZMyE/+tKiaw9nGnTETgTWXOE+ZcBTEl6oqn8i1CFIWd7dNmACxoZBd6KERyGk4TGXvJq0M0pcbAy79ZDYHY9IdKAVDrZCHxT
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=M5GUcnROAAAA:8
    a=fY6gTh1MpCnGrHWHiqAA:9 a=im1nUl6bP0GLF_8d:21 a=sleQOe8fID77la1R:21
    a=OBjm3rFKGHvpk9ecZwUJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755614AbeDXEQp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 00:16:45 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40740 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755595AbeDXEQl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Apr 2018 00:16:41 -0400
From: <xswang@marvell.com>
To: <linux-ide@vger.kernel.org>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: <oferh@marvell.com>, <dingwei@marvell.com>, <xigu@marvell.com>,
        <nadavh@marvell.com>, Evan Wang <xswang@marvell.com>
Subject: [PATCH 0/2] Allow drivers to override stop_engine
Date: Tue, 24 Apr 2018 12:06:43 +0800
Message-ID: <1524542805-11349-1-git-send-email-xswang@marvell.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_09:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=186 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240040
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Evan Wang <xswang@marvell.com>

There maybe some special operations needed when stop engine
for AHCI IP of different vendors, so it is necessary to override
ahci_stop_engine() when stop the engine like overriding start_engine().

Evan Wang (2):
  libahci: Allow drivers to override stop_engine
  ata: ahci: mvebu: override ahci_stop_engine for mvebu AHCI

 drivers/ata/ahci.c          |  6 ++---
 drivers/ata/ahci.h          |  7 ++++++
 drivers/ata/ahci_mvebu.c    | 56 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci_qoriq.c    |  2 +-
 drivers/ata/ahci_xgene.c    |  4 ++--
 drivers/ata/libahci.c       | 20 +++++++++-------
 drivers/ata/sata_highbank.c |  2 +-
 7 files changed, 82 insertions(+), 15 deletions(-)

-- 
1.9.1
