Return-Path: <SRS0=vINO=HP=oracle.com=dan.carpenter@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1950236-1524722016-2-10433332980223414591
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
    1524722016; b=LD91U5RhtAPPW0Twi61Rau4rKBOTG8DJmhkQquzNM77yzgAkU3
    VROI5AlpTbgrLHwDodmipUqZGCwVlkKFPJGbS/tPCX0IMnc936OI/PZXfQXJfsEg
    0BLWPCwE4ENWEeCQ9CIHTwnR9hzXxggmjC0+Z/A90buwrUABNCjv4mksRRH3B6Ml
    YuQxjL7iuNdF6HmJn7V1rLhXEnpQOCDgfsdVI3/SrBq37sp2B8Fz77x10Ll8wghn
    kplTIVdHPuDUFtl/rOoJN06vJiOxf7IGXucapq2e5EHrttKxCc5nBrJTXKH3ZfnX
    xReK5kf738Bp1HzVrgDXrkXuaBvfEncJG+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:in-reply-to; s=fm2; t=1524722016; bh=
    z47h+h0DO6eOn77AphXbNoqmAoLe7psPnhahk3qcR6Y=; b=Ksn7bisBBXkmqDg2
    N6Eu2DXLH9Mz+rDpQyjqpX2QAC9vySBeU6l7UVnQHgZYxUcg23AVQdpQUpTgViaf
    z4nQJEApZbWgORhnVZeocdDrChlfKfL7Na9SIcLM5vHE9zMCHU4lXG9EKbjMCeV7
    nE58Mf73Bybxiglby2iYrvoUpR050QVFuHNVVBU1Q4hc3zCo4k4BKtzQq3lMepzn
    RQGZOJ/yu2EiXkTxJCZZMJaf9xRHIQtLUv4sKAkspAtfgXIdVIsGhRHG5+s2LtfG
    //2Lff3k2zA7JBpKu39Fe6H/BGOENhuVEpQd/qrnhB6ri4WOKXvsjf097/xCdlYp
    V7r46Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=XXMaeBCq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
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
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=XXMaeBCq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
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
X-CM-Envelope: MS4wfEif4ScGhGwLzlJhe5JqPqHGjJqZTgZhyIyZVkgwmHzuFNWJDXe+P/fKlw5T3GPLzcZ+IxREoUCbw4rFww3lA0uAb4pj6aJgVsLisBKdjGH7jV5OnJ+C
    G9hp+4Dnoj241HOVd6RmBDbY3G1G8O/arEk4xwRRQOh7ePqPt+qQdGtocDu4bdOMS9JngMVD40inTDInTn0m0Lk+K0B/rI1omdC6O+oFp0uSOKsyU0KWRJOW
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=AYtqSYW1AAAA:8 a=yPCof4ZbAAAA:8 a=ceuQRidhCnFJna1kl1kA:9
    a=WpSYC48JA_2gNdni:21 a=eGaSVoPcY3_w-n7C:21 a=CjuIK1q_8ugA:10
    a=WtHkaixNIbui_3fsm1s1:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40E421745
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=dan.carpenter@oracle.com
Date: Thu, 26 Apr 2018 08:53:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sun Peng <sun_peng@topsec.com.cn>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        security@kernel.org, Tony Lindgren <tony@atomide.com>,
        Lars Poeschel <poeschel@lemonage.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/4] tty: n_gsm: Prevent a potential use after free
Message-ID: <20180426055321.GA15363@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420083028.7fq3hw2mjjd7nrra@mwanda>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260056
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We're freeing the gsm->dlci[] array elements but leaving the freed
pointers hanging around.

My concern here is if we use the ioctl to change the config, it triggers
a restart in gsmld_config().  In that case, we would only reset the
first ->dlci[0] element and not the others so it does look to me like a
possible use after free.

Reported-by: Sun Peng <sun_peng@topsec.com.cn>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index cc7f68814200..1f2fd9e76fe0 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2075,9 +2075,11 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm)
 
 	/* Free up any link layer users */
 	mutex_lock(&gsm->mutex);
-	for (i = 0; i < NUM_DLCI; i++)
+	for (i = 0; i < NUM_DLCI; i++) {
 		if (gsm->dlci[i])
 			gsm_dlci_release(gsm->dlci[i]);
+		gsm->dlci[i] = NULL;
+	}
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	list_for_each_entry_safe(txq, ntxq, &gsm->tx_list, list)
