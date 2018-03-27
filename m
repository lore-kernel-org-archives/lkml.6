Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2744290-1522128086-2-7694260948386970141
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522128085; b=bbCqlEF/I6xdu28SQdBGj7S9lMyeZdchlJVLhIgjPzShaUV
    UzrsTdhzMms7a5f083ER0FSFEe0QI+ii9rhjNGh/UtNVT82cj/uqketV26V92CL6
    BxPGk8bgVGQLX9/H3mqiJky5ipZd/cBzHq2u94/rYY6YZkvljziOI5i8ivUNkAwi
    Epd0ucIn3scAuI0A+BT+5R29xYxZTfrroqVMIZo1OS9Vs65bZchJAqWQThtvLPaF
    NisHHR9bRK697Pfk9k/sMQg2s+5GszA1EjTvH/e9872uEfR9vf1Hzl6eEMVjQQa9
    bO+qo9C9urKsfm9EjOUCRPx4p6dc2USrEgfOlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522128085; bh=I
    XpmULcBWWnkYuilU5h6UMkfmjz4ELHKaW5k+EcI9VQ=; b=uGaVxiRawOTWbckUT
    0KR/6LE4vtckmqs2igvqxWtxOGXwUHmFuZSsrkuWfTCmKdzUJOjcfWsHTgh/wGm+
    ssjekKgG15RlwhE5ebxgtg4rd+doXnRELMWSP8Y2g/bslWf/6RNK1Hd4O66RkvUP
    oFeAuychMy79/e5FmhYSLTeClbGv7DE5qMF5bbdT0DZQvQr1AK290vjMhCxd+D7e
    +p0jrp0CdzYD3sDhKsZfDuuVAJ8+LAgr5PnFw8W6/r4XTlKUpvIbeUF92VTaugqC
    nul/sNuJdr19hkHRcioyraAyAiioaTdshpCRVUMUco/M1q4Une+7P0XyfRkLKVZQ
    FyFXg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=JSRN8fu/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=JSRN8fu/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKza26HgaelFNXgECI2I5z+c0Utdxosvq36AoSzuLD3ZmSkBIg/LytAgy0LUE8q+InbQdyv1NQVzpfsRtJ3oSI8eEpfZvYio9klSIi3jdPndr0msUHUS
    KKF8jQoqq+TN/KOtnuOQQvGtLrMRZWb1YL9lDCiHNCUNLPTXgPQAB/06qbewU5Gs8C2a7bHG3VV21n+bRX0rFTd4nihes6+EEPBSQPWvJHKsFd4LKiEyYxEf
    e4kCX+dDFCDqgOvRZTiu2Q==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=wb2I1E-Hr_TaPNiZW4AA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 27 Mar 2018 08:20:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
Subject: Re: [PATCH v3 1/2] staging: media: davinci_vpfe: add error handling
 on kmalloc failure
Message-ID: <20180327052058.xphi47mnnbtjl2fc@mwanda>
References: <CGME20180321043915epcas1p3955f5a57c6728cd1f386f805879fc3f2@epcas1p3.samsung.com>
 <1521607150-31307-1-git-send-email-ji_hun.kim@samsung.com>
 <20180327050045.GA12754@ubuntu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180327050045.GA12754@ubuntu>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844
 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=805
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803270052
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 arvind.yadav.cs@gmail.com, mchehab@kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 02:00:45PM +0900, Ji-Hun Kim wrote:
> 
> Are there any opinions? I'd like to know how this patch is going.
> 


Looks good.  Thanks!

Greg just hasn't gotten to it yet.

regards,
dan carpenter


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
