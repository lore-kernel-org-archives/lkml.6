Return-Path: <SRS0=vINO=HP=oracle.com=dan.carpenter@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1950236-1524722078-2-11697392480731565438
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  UNPARSEABLE_RELAY 0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=vINO=HP=oracle.com=dan.carpenter@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524722077; b=FNQUIL+fMndteSqjH0ADmQG/UNn8rgeCLt9J4svUMoaPhdJmw2
    2ihMcf/ly755R5+Mptarb2OkIzAyPX5O7WLdUTyeK2wmdVhB00u13Nx//uKo+vcy
    VPVQ4Jwvl98tr8F3ujUpfDbzXGhiYOscdMEKLbR5CZ4kOytcnSyThx5baJ/kLq2s
    A+SMTEa7bTuunJRSfJ1mV9lz4OOoOnfmQ0vL2uMAYhlok8Ad2Tf3SKk1vTalULY8
    rDYh6z97wHptOrxo0fosDnP+JdpHgahcaTJ0IjIW4/OZQE0UbXSIEqy52mJanJTi
    XDGn8CozlTcHztW4v9huKwCROQgweRczzkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:in-reply-to; s=fm2; t=1524722077; bh=
    ICrElO9JzQ8/Sq6/5p52wYiRbj8bPD1dK18zAuBIKkc=; b=wLVIppr1ykORyMoP
    MlLgq36DhwXLJs3NX4vB5nPolSxfzvYYMT6fX/rq1g+F4tFWiAGXUQRUMBSQm6zo
    hD9c+yJL2xQiAGkvqZIYJh72L6p2toNShfv2IgNO0IFnZS2ZaUx7vuyQ+Iq54BKB
    5D+RFdIzNgYPgrqcBzstVQudEODorP5oHKOGeS80GxRN5YRyR5a25xBkSQoVopaC
    4hc8E41LxfAchSbltGPqOexEcpTHVyLsR8Sgtw6CSOPd+gJXb/ThC6XlWMDudpMY
    3zH0ufKmmYILPYPZ5O44VyTB+brv9IJYOe61DlCUC5+5OtsbsOjz2TIoosQcPZ8K
    1VxWDw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=MUhKI201 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=vINO=HP=oracle.com=dan.carpenter@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=MUhKI201 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
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
X-CM-Envelope: MS4wfAaofwP4XRyt9+tA7FaXxwufko/7oiCyJGr6+uPlu0f0ISfGcgvUNY6ETvdjIF/klHeOf4NrNjBHI0EZXLptc9mzzcV08LdsjFNjL5St/pVM75j7p1To
    ar/IHGsvWNDgWd+a74YI2UCZY9UFGD5V2S8SHL5WRagTcz24OIqLo9HwuPXLtT9gBLFMNBepihLH4XbOsbmEJg4DdqD0KCiOHefjtkMfJYF3CQWAFzyyE2C2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=AYtqSYW1AAAA:8 a=yPCof4ZbAAAA:8 a=uFetm4Hs0fKI03Y4k7YA:9 a=CjuIK1q_8ugA:10
    a=WtHkaixNIbui_3fsm1s1:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B16521781
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=dan.carpenter@oracle.com
Date: Thu, 26 Apr 2018 08:54:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sun Peng <sun_peng@topsec.com.cn>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        security@kernel.org, Tony Lindgren <tony@atomide.com>,
        Lars Poeschel <poeschel@lemonage.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4/4] tty: n_gsm: Fix the test for if DLCI0 is open
Message-ID: <20180426055421.GB15363@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420083028.7fq3hw2mjjd7nrra@mwanda>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=935
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260056
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Logically, if gsm->dlci[0] is NULL then it's not open.  Also if it's
NULL then we would Oops when we do dlci_get(gsm->dlci[0]); at the end
of the function.

Reported-by: Sun Peng <sun_peng@topsec.com.cn>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 44e9c5e3dbc1..660153538ca7 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2919,7 +2919,7 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 	perspective as we don't have to worry about this
 	if DLCI0 is lost */
 	mutex_lock(&gsm->mutex);
-	if (gsm->dlci[0] && gsm->dlci[0]->state != DLCI_OPEN) {
+	if (!gsm->dlci[0] || gsm->dlci[0]->state != DLCI_OPEN) {
 		mutex_unlock(&gsm->mutex);
 		return -EL2NSYNC;
 	}
