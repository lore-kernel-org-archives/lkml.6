Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1311226-1522755099-2-7282373749550641788
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522755099; b=mEfLlejDYbyoziqjZTcYjkFqErIFzyG+xPGz6/HvYaa5/ugTOG
    gZQC+4Xr2liG2WkFMYllWgNL+k0NnPzKePV41HLhoGOZdXEKLZpfiMXHRG/1JMjW
    BxziOmw+Hf+deEAq5VwMt1DKwuNmhNVY12qBhRgWY4/ZwyzAByJ/f4BA/us8cP6s
    +tk5Kt0LLWHYRIAUvG/G/nmRMUf9W6cVXJiiLRYxgVzghVFAFbGph/KE7ffXfXc1
    90YmwGWvnlYVhjPctT+xN5BCiAHtguakJLRnonwHPqhGCC3ENBQ3TQAKBekG194C
    62ZCBUGcygI2dyUljreUzMuxBVCtTmcWBTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522755099; bh=W5SO0
    R4pnMX2cAN+cv40e9nCBf/I3NjsHvmmcWGsAMI=; b=LVvPoLeeHicQx6zmoz8TS
    t5ZFP09RIPwUhecUxZIZM6H05P+tt32E3vX1hkHws87YbL8wjl+xgPKQE/ilQwfR
    /pHcbzi7bzmzEanqtgvinUOEEHvCeb2q6HtJc2DqU4m6BA6fNm8/n7uG6Yn1urgj
    d3F0+5fJpo0DmMUfwgD2uzDjzr4KD090qehlaLudQBL7+9YDWNazKozFVXdEjZBA
    6ldN4MGLogy6FzqCWSbAKaHk269K55vzH+7uvCBlpl55OOn//neYo6DlMz7lbd4P
    AhopGWqbefxxoqY3PPlOnlePWv/MCui5siGn+/WmQtNKYnoavj7Sh38Xq9FRe8GQ
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=G2y2L62g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=G2y2L62g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBp/Lv+nGdhWiX9yCZMg2CkR/w3kHLgHTRL/Fm+jK3mZmgo94rkzZ+W1a4zG8xsA5zZ/+WEtay1TmSaDA7ZEMA285JgzJMCP0LataRQVhcEX/BuzXUz5
    C6tLTxsqqr+TNDka3h9mITQmr517fIW3VBFSHCR8Y7GUMgbcYiS2VnFJ3vtbE6Es/bUUkTiHPT1+uLuV4XFWNDJrUisyoioGAHKx57d0HrmvcTqQuoz82ApS
    ljo8+/32a2dL79sa6j3esw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=pcpMsqnfEaXoKf1XRqIA:9
    a=CjuIK1q_8ugA:10 a=pC-h2on8RWMA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 3 Apr 2018 14:12:10 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
Subject: Re: [PATCH v4 1/2] staging: vt6655: check for memory allocation
 failures
Message-ID: <20180403111210.utskcq6255k6o6tq@mwanda>
References: <CGME20180330055207epcas1p14d562f44802bac86a8a7cd95fe2d009f@epcas1p1.samsung.com>
 <1522389115-1124-1-git-send-email-ji_hun.kim@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1522389115-1124-1-git-send-email-ji_hun.kim@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8851
 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=551
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030118
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, y.k.oh@samsung.com, gregkh@linuxfoundation.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 julia.lawall@lip6.fr, baijiaju1990@gmail.com, forest@alittletooquiet.net,
 santhameena13@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This will crash.  Please see my comments that I just posted to v3.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
