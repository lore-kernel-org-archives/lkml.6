Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-837036-1526304606-2-2840257798993282658
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES endafr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526304605; b=eBupWB77oJlLiyXbVQYGdJDErU6yeKRLS1xoAkwSCPEcHH8QFc
    jEfGOb+h0fTa54p1V150tj4Rs0zkawTCys/WmQ62oAU/1c+roGppSRr8VLMkbhFF
    RcBb20TanX9nWLXyeZ+lJ07Xmh/X6kgOwgkpCihBPjse7raMhaExgFRfWTxSZX1D
    WPam8mqQ1AtNL8sRhj8lR8D5exaqo3fx2TntQ7E6om7dz4FjJFqF0FnqoKMAsgND
    vAGYcgKQu6VRY+CuAtPOYPKSdAwPol2J9TEXOlCWoM/FFVFgJyo9H8hoGzJ7JFjU
    owcBB9ypv2w2eD8d9kv8dMMiFRoO5SKY6qhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526304605; bh=uRU50
    a0/B/Yl8eF8vHMk6QW7qTRn7/Dzt6DM2JV0bzc=; b=DBgnRPN1Yyy2NQa5t6yQV
    PPlzGJ4EDkdtNldv9DfQF5AbYtZ5Tgpv5hEjzdMTNlGfjnL72N2LkUielZHNk8SS
    5h63lnmBFtg5N25d43nsUmit+p98S+SgaPDojkWqVPor35K/7M7ERkIuyzRFxEDM
    5/UJJal9U7Mpw5Ju/u7Nu2j+jjPsRIdRDWv8YJ7jnUzHhXOmtdMfsv5SJTTZAY+Y
    3xIOdkOB2rPbJHHg/rdtnveVhk6HBYHuyxjWoETdwB0ZY46dHPZWWe384AuvSnNn
    qDDixv1T0dEiY9YtzBOMwkbGNK9yajNy4pEdWPnKWKNNYKXicA1JSeBwiU+AK4Cq
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=Zy5GLR3O x-bits=2048
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=Zy5GLR3O x-bits=2048
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
X-CM-Envelope: MS4wfAZt7rAChC25bcu7l109PFDfZmivwDrufPrie2cbYl28dJwm6gbUa21X2srw0IUC0HVY/AM7X95nl1YVmHlPPGRrQw4tXPfceq1Ggf6xCLx1U+/9JB3T
    Ha0KOrahV5Zd/e1cb+F53KzIVkAIKYIbQ8HLII3YRQeZNL3sXFotmKdxWv9IPsji34rERvMsQ2zbdYlIeaU6CSXN7Cps933xkG22jJh2wthc8fEuB8O15wFI
    MPDG52ZibfIDF8U+H0hoZQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=gM39DXBaktZxdYdSBS8A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 14 May 2018 16:29:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 2/6] staging: android: Clean up license identifiers
Message-ID: <20180514132945.jofe4rb3ml4muusa@mwanda>
References: <20180507011328.11982-1-natechancellor@gmail.com>
 <20180507011328.11982-2-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180507011328.11982-2-natechancellor@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8892
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=952
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805140139
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
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
 Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 06, 2018 at 06:13:24PM -0700, Nathan Chancellor wrote:
> Add the identifiers when missing and fix the ones already present
> according to checkpatch.pl.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/android/ashmem.h        |  6 +-----
>  drivers/staging/android/uapi/ashmem.h   |  6 +-----
>  drivers/staging/android/uapi/vsoc_shm.h | 10 +---------
>  drivers/staging/android/vsoc.c          | 11 +----------
>  4 files changed, 4 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/android/ashmem.h b/drivers/staging/android/ashmem.h
> index 60d7208f110a..1a478173cd21 100644
> --- a/drivers/staging/android/ashmem.h
> +++ b/drivers/staging/android/ashmem.h
> @@ -1,13 +1,9 @@
> -// SPDX-License-Identifier: (GPL-2.0 OR Apache-2.0)
> +/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */


// was correct for SPDX headers.


regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
