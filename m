Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-437838-1525250396-2-10011461387727806341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525250395; b=lPrxAU4PLa/s3OYUGBVVaa+GxBlKe8DQUH9QHI3qoV5b4zZEK0
    zgFOmM8HOvw6BYLG4d0gbmwXzrSe336wxwmFCIjeItFFJThxxYs8U7m1FGSmnnuv
    tfsd31Gfb3GhhKvtFYiTppMGSH64wVnY6YZjlvtIg+fNXiD9K9bP9WEpjmNs+/Qr
    Lg8HI/Ct8C0ukJ5gPbrb5PX5DRVkAUbD8qtZhNbdbX+ypA09geM2iPGh/rg5IOLj
    rsc3NFbwylM2Wh2bADd789W/DfiPNmYwk7VTAHN5CAvhcyYqpElPS7eZRz1l0XIV
    KPu4R3v+TAezq1tFmLjwgQTGUuEVpa1y3zHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525250395; bh=iN8HT
    T13tZeLHpvND3tSkJueKY3zo4bQlhDwVnHl8Bs=; b=N7Je+YMbwuOX6kQuJZRBE
    nVvdN+r2EwBF/Doa3mbRoOXkvPPRxukCFStptMjxoaVEsINple4RzD9PrBITdA/b
    3MhaTP8AnZV9WU8xZ/pLjLAlNcXBb5dR9gElWDPimS9dF6TNs3KWlRGVQJpN2b0I
    reI4xUR0IDYem9kbkAvSv6wkndoZAkZH4eiQox8rgd4hCs45BNv41qA5aGutk6wP
    8oht3x94SCitFm8PDYN1ViWn4e3oxnj33g6Jit/SXIPkCwcdSiORccn8dESmHrkU
    pzXEqCpVS8+JSl8hSWU64LHKhhXmp1a/iONXQDdCXllUPofxLY70zxT+w+/tHUKM
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=dTM5DNob x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=dTM5DNob x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLnY1rnAcAa7n7D48RF44A1wZJF0P/3ofP7o75DkTeXVu44pIw4MfzdR9n567/0pCpZ9Bsxfwbm6bPKSQWKmh1MrfWSA+sNbDBOBv82F2nbdJ+pSe5dk
    G0Owxho446SQnxXQXEsWN4G6h8Qh+2YJYZDNQbiLcFnW6Q6MSvRZpuki/za3l7RLZ7OwYh0AZnhKjq/6t6hkq6qzPgx8kwAWG5UKRRKxOXNDUi1ZR0IYYN6A
    eNb4RL4ZT4L4CK/IX99yVg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=7pO1tdIXdoeQ3E2ah2YA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 2 May 2018 11:39:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ajay Singh <ajay.kathat@microchip.com>
Subject: Re: [PATCH] staging: wilc1000: fix infinite loop and out-of-bounds
 access
Message-ID: <20180502083935.uw4mxvcgnpayv3h3@mwanda>
References: <20180430125040.GA19050@embeddedor.com>
 <20180430195916.596a93eb@ajaysk-VirtualBox>
 <20180430152321.7pq4ol2ed7tzsrl4@mwanda>
 <20180502111735.5a2c6faa@ajaysk-VirtualBox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180502111735.5a2c6faa@ajaysk-VirtualBox>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8880
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805020074
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
Cc: devel@driverdev.osuosl.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ganesh Krishna <ganesh.krishna@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We're mainly discussing readability, right?

To me when people use "int" that tells me as a reader that we don't need
to think about the type.  It's going to be a small number.

Say you have data which the user can control, then it's super important
to focus on the data types.  We don't focus on it enough.  There is some
kind of idea that good developers should just be super focused on
everything all the time, but I don't think humans can do it.  So to me
it's useful when the author tells me, "This an int type.  It's fine.
This is not critical."

If you make request->n_ssids a u8 or u16, that isn't going to save any
memory because the struct is padded.  You'd also need to audit a bunch
of code to make sure that we don't overflow the u16.  If you wanted to
overflow the int, you'd need to allocate several gigs of memory but
kmalloc() is capped at KMALLOC_MAX_SIZE (4MB) so that's not possible.
How many of these structs do we allocate?  Is it really worth optimizing
the heck out of it?

There are times where want to be very deliberate with our types because
we're dealing the large numbers, or user data or fast paths.  But there
are other times where int is fine...

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
