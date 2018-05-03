Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1890012-1525324324-2-13715261902416804062
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525324324; b=lwEZ1ioj35Z7PaHVf1yWHt66Kz393f/kUjmFWzs6MZSgpAztjE
    hnjDXjNs/7rcW90S0Lf7v9vWH8+9ApkW1w1GYwpfPMhkhuRDi8PmPcFGwlJHbTVG
    xreQZqP8f3FFJ028P2LRw2HagnkewBak1P0AOaszJkGiAOUYIf9lw3u1LOcUCN7r
    CmRA4KFq6YlsbJ2ySWpGS5BOJmqgNauPUBhrL/g0Xbl/42vvjVSBXSnVfY9zJrZS
    w4frDKOYzRIZwUAGO59JFYyXOsOdn9Oe+MucuRcezEOuZg+qr1w3E645LXWg0iMs
    VVaIgmc2M1iiN4cV7UIQzoA8GRb4l1r543Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525324324; bh=0UR0X
    BFNzbFQEEVS2A56hXdduI2dlLhAW92i72hrEJg=; b=QtvoF18H4rESU69z/w0vB
    yATtYQfebBXNoHr9+tVZvRmS7nTAZGpje7B+V6s2XMO9lu/02aKANmhZz90nLsIb
    +2C05AnAov/YsQnRChLNFI29f7FBclHaM77D0QO7TxBSlFRN1f1quP12KMz0ksad
    glQZTD2Sm2CRgwNwD6Mz4Ya3rz2dVMrywDMG3MfabEwXq6zWKFNgVk4sl054APtF
    asw6FMMlz+1GDN+SpCarI3f2x3YAZkDP/YrUgnsdnAlCSQsjMUX2SEuj01AgHlof
    eBCU2RLfmJhRWYUBQnY6R1an52ZkPPnT+LBcLJ4cQffxx/lMkjzINQyTYj9x6IEC
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=QEYevNQQ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=D9ttsiRh;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=google.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=QEYevNQQ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=D9ttsiRh;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=google.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPfGE1Uszsgnh3CgisbEjopIRtGLKEDa/UpdkiiinKn9qceFZvg2/igQiKbk+kQEI61QB3abfK7REuB3Fb+1fyarqD8hKCeq2wrZ6EqF4x7zLrdlYABB
    G1ysSGx/wQW04KSizMTeO00mkDedrgSFrTo/vR3MU1W9RFas6a290boIJC6rxNZjrwkMCEnHxoiw37CeEfd7UUe2Gz8OGkGgrTnF6UWMhlPK67t51IKeFWfv
    4eahV4iahckt1lkybO/sRg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=n8i27M1mAAAA:8 a=DDOyTI_5AAAA:8
    a=-7MKdVEiL9JvSsn6PvUA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZosJQ/G7Kt60Fig1ygLsCM2kKs0SXE/5052+axiXvr1sx5kegbVZnTYh1q9y/krDwcy+WSw0jJbtM23YcF3pno=
MIME-Version: 1.0
References: <20180503044521.156965-1-astrachan@google.com>
In-Reply-To: <20180503044521.156965-1-astrachan@google.com>
From: Joel Fernandes <joelaf@google.com>
Date: Thu, 03 May 2018 05:11:42 +0000
Message-ID: <CAJWu+oof2VRWSeXGjTaP3M8tP4B9=kLw_nLN08bpCprYSYuh0g@mail.gmail.com>
Subject: Re: [kernel-team] [PATCH 1/3] staging: Android: vsoc: Create wc
 kernel mapping for region shm.
To: Alistair Strachan <astrachan@google.com>
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
Cc: devel@driverdev.osuosl.org, "Cc: Android Kernel" <kernel-team@android.com>,
 Todd Kjos <tkjos@android.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ghartman@google.com, LKML <linux-kernel@vger.kernel.org>,
 Arve Hjonnevag <arve@android.com>, maco@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 9:45 PM 'Alistair Strachan' via kernel-team <
kernel-team@android.com> wrote:

> Map the region shm as write-combining instead of uncachable.


I think more commit message is needed. Why is this done, what does it fix,
etc. Its hard to know what the improvement is without a cover-letter either.

I am assuming the improvement is in performance by using the
write-combining mode.

thanks,

- Joel
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
