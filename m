Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-646324-1518419200-2-8566694006982169548
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518419199; b=tN7M1IKesWYqkWhZBU3T7WckOtAHg3UtMxvyxOfzErXfRuT
    u0fWXu64bEUnDtsQ3kOsmoVHM4ROqWHe9oWk0CmWC9RomF/we8p8ZZEhk71KFufg
    EAesJcpGH87zQQYswEtqdcO8rln62hh6kaTUkwEw7PsIeQmNIgjWa8igo5ph0WbB
    uSsZ0Lz5p1FzlQs+VtF2dnaLGRFEQB54O1SkQxHzZ0duZ64uO50s5TAbYmvD69U+
    NTW/zmLykCfKef6UTOhxSCNV5PKzJFc4xelxLraNbtXoo2G+gc5nlBrduErMWZqX
    uB4E2r3e8Wv49Mj729ch37W0c5uPnwRKl58SSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518419199; bh=k
    NWj5pIvQl+XwUMSXRW2aXsZLWoV48AdbYU1lN9Q6/8=; b=IzfxLRXv5h2DRev6U
    pzRHbExma9Yuo2BZh2uriC/7w2Ca6aXuguQeg4aIeSjHUtGAKz+dDJzqGJFRqJ0E
    iw3HnHWD99oSrnBgwox+4fiAhydtwunhE9zKGbco5NrJH3rhokkcnm6y7s+FA5ik
    S7WslpFMfSsSFQm2NRHWrqLn4dg2vYPDU750q36L7CUuSu+e05jqozPK0K1gOg/V
    rb9SfC4XKLviEIGdUiw9lOtr7iHPZ2ENQvUS9ZE/dV6Ib/VghVbCRtagjkDvpEuR
    4pMz5wvpJAkjHzgRp+v9SKJwD6At29jdGu2chVWv2wYY0QDYsKbMMG5i58MVshMC
    qVhWw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=l6m4/gT2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=l6m4/gT2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 12 Feb 2018 09:56:20 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Liam Mark <lmark@codeaurora.org>
Subject: Re: [PATCH] staging: android: ion: Initialize dma_address of new sg
 list
Message-ID: <20180212065620.iqlzczhqzlrmel5n@mwanda>
References: <alpine.DEB.2.02.1802092203150.2846@lmark-linux.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1802092203150.2846@lmark-linux.qualcomm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802
 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=828
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120091
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
Cc: devel@driverdev.osuosl.org, linaro-mm-sig@lists.linaro.org,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 10:16:56PM -0800, Liam Mark wrote:
> Fix the dup_sg_table function to initialize the dma_address of the new
> sg list entries instead of the source dma_address entries.
> 
> Fixes: 17fd283f3870 ("staging: android: ion: Duplicate sg_table")
> Signed-off-by: Liam Mark <lmark@codeaurora.org>

How did you find this bug?  What are the user visible effects of this
bug?  I'm probably going to ask you to send a v2 patch with a new
changelog depending on the answers to these questions.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
