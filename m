Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2451662-1522919688-2-16887408698482118606
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522919688; b=kQVHS3HMe8Tfqa3Fx+Y3ouGMpS0yWmnRj3y9wXUGjHOJvNl3Ct
    zK/d0q8tR7m+jb4j16OeTRL9bzgFsZ6bzkrLgN4AnUoBrFa2JfoPThy0PfdNiSyu
    vACFruFPFU+eTA1eusOGxChSMHde2fuNhI8rFCSUQDD1tKqMa2GDYYQ/zvFlV1kF
    2OgU3KzmXmJBV1zSD/ZXjjsKNxqwYEj/SebNTCO0lKwEANavt404ZMmu49iMrllF
    9SGnGZ08WsetmwhHNaTLBkVaGjswjF0P1S51fIDsWpwxVTL0kD8AJrzPOGbB0mmH
    FcCBTRUJseDsRAoPhl+1zlr2ynBIBsCBvrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522919688; bh=iHfep
    LXmpSnbOQn3Oj/RKLtc9aXhPWGa6fAanr+DyYk=; b=cuBX/O/PReaiU7SEaZx/r
    MuJJ3ZxBrk1RdK8o+58KKTDxn/OOJXnM4GZSRIQXjdr8pVv7PCCue6GW75ZqWsz6
    uuar+QABxPTa0/rej/R5Gr385qFCScgtjXGDNXAhX1l2C5IsDtQd97XC3SH1xFta
    mzPiXYyJF2BhpBE3tCwisaVg1igc5Ld37Yz6/r9TZ1RP1oeRkFy73rornWeQBnAx
    CLyM3c8NRwJ8eTqvuA7hnJZfMTqDNk5LjKclt8gPqaPu9ZP0vExlKmdoSPvcEFq7
    CtIbs8q4qp2RzzXcEj0eY5ZD4nPT8SrepCJ66ggeivNK3YD32qonL4pF0a9lHcEh
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=h538D1KQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=h538D1KQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO27O4l9qksNTjR5mzIxQl6xjyqRqx7RUBWWviUM769NBMR6thuR32xA764w5a0DU32Lpa7aUE6JYN7sW9P5bnrP2LVD/d20w/KtcIf2QwkUiZOiQZem
    Nt+obVXKT0vM0OhD166jiY3HzYcC4YMA3TN6LTDX5lbRQonlo1BKKA1/vnjsRs0+qPYbcWB1la5nW+caHg9fHHWUyDHcqEnPHGgaRNK3XU/LsH7uy0HJ9O4V
    voA3xO0fciHXsvUakiTnJA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8 a=DDOyTI_5AAAA:8
    a=4qRMPVGAMDAQsf45P5gA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 5 Apr 2018 12:14:27 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
Subject: Re: [PATCH v5 1/2] staging: vt6655: check for memory allocation
 failures
Message-ID: <20180405091427.n2i2hnaoijxrucrb@mwanda>
References: <CGME20180405071018epcas2p193288469c86f6afb2c8f7b0151dd400c@epcas2p1.samsung.com>
 <1522912160-21009-1-git-send-email-ji_hun.kim@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1522912160-21009-1-git-send-email-ji_hun.kim@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8853
 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=640
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804050098
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

Thanks.  These look good.  And to me, it's really easy to review now.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
