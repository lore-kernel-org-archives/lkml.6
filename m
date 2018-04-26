Return-Path: <SRS0=vINO=HP=oracle.com=dan.carpenter@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1849447-1524722034-2-1364395411231257343
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  UNPARSEABLE_RELAY 0.001, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=vINO=HP=oracle.com=dan.carpenter@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524722034; b=OANV1H/sn4+MY1GbgL838L11981iuYFJslIKbQHdHM53nPwGLk
    JVRvlVNijdAEo0tYPA75pckS2oOzDfPV+GXZ9j6GjbKaV73Tx5uuGRr9DiM8tPGA
    IsrFTCxPAwgV2yqXInNhdGeXJ3ym8+3oyb5q8lAFYQ29vczmnfrioAapEJ5A6h+A
    oq2mL6pe5ZqwXyBpcK9Z0alltlHlLLUCyrB3zkKBxW04Nf3r98eoOqfVrzN0AIVv
    vCCKjnuDFug68ha1+edfqtcfmGEAUkALujk9ZBSNskVvfL35T/fMflpODSveqLVA
    2SK6C7mzUDj/7S5PwbOWfEkDo7VpCX1sUwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:in-reply-to; s=fm2; t=1524722034; bh=
    03hD9gQgg8UnwDuCYBstJP6Z7EwYIAKNFpIrFMqD8YI=; b=O12Ugz1+elB/CSvc
    XrjVSXLvboF+0IHBxaC4jzu97n9eMLJPfRs+wnl2u7q4rqW8jl5bgnqRa81Tjwyz
    flz51xcy9irc4XRWVGUIGPRGivM8v24OSYxC5TPKk54VvWmijx//xrNt2+3VPn1j
    oLN1jut8sINNszkg4BVFjRmGr9yYM/WSVVI2V/V77YIijCanjIMdVRAFkw7Hjmch
    xHmQ8hN3hkCzq2PGvqHGFscAV3FXH/iWglpytZWYupyFhDRw+BxXK2kTMRLVywZm
    cUGwQzsMdtf7YpOp612WBK04s2WWhItR8WeXjxECEVD6aM4TaQp82tiI+wnWe+Bt
    jNaLJg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Qf7Mw8Lo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=vINO=HP=oracle.com=dan.carpenter@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Qf7Mw8Lo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=vINO=HP=oracle.com=dan.carpenter@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfExk7PWDedMqg2hbY7rPrKD39KA/kYVHwjC/3Le8/OXrXj156z0DsBlkiXqklv/KtV23oIj0uzf3yuYN+r6lfnib902PEPJ64uzaOJDuBIQCRbpizs4+
    tpBu5w5T4nlgQ3OaF1r4B092TT7KJ0nJk9LHjR5KxeIy6yHFjMbYQwaZ57jg2dQCrkBNeRhNyQcq3LfJZx+feGyRZtX699QNZRGXEHOZa2KwedZ9VrCy0T7b
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=wDA2uXUJcsCD3O8AYbYA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAE421745
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=dan.carpenter@oracle.com
Date: Thu, 26 Apr 2018 08:53:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sun Peng <sun_peng@topsec.com.cn>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        security@kernel.org, Tony Lindgren <tony@atomide.com>,
        Lars Poeschel <poeschel@lemonage.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/4] tty: n_gsm: Remove an unused lock
Message-ID: <20180426055337.GB15229@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420083028.7fq3hw2mjjd7nrra@mwanda>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=800
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260056
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We don't use this spin_lock so we can remove the dead code.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1f2fd9e76fe0..44e9c5e3dbc1 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -177,7 +177,6 @@ struct gsm_control {
 
 struct gsm_mux {
 	struct tty_struct *tty;		/* The tty our ldisc is bound to */
-	spinlock_t lock;
 	struct mutex mutex;
 	unsigned int num;
 	struct kref ref;
@@ -2188,7 +2187,6 @@ static struct gsm_mux *gsm_alloc_mux(void)
 		kfree(gsm);
 		return NULL;
 	}
-	spin_lock_init(&gsm->lock);
 	mutex_init(&gsm->mutex);
 	kref_init(&gsm->ref);
 	INIT_LIST_HEAD(&gsm->tx_list);
