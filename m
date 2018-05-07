Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1062290-1525698950-2-17052404913620941366
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_06_12 1.543,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525698949; b=lXTS8BNbMiNL7M2mENlnScQYr8zBS0vo2NH/zc/JXBCW//tUax
    1FPBn1OrYZpGPBJ8U0SsAdDX3HPPNF9o1IzQMuOVW8Xlqp/1okvLqK2gccMku8O4
    TIMezL+pLjtCdAeKqFPb633YvsmKaMzkAvmbDdxCYW9I0vjBazDWWkbWeby1wnNQ
    VjUOTvWs/DbNoV0sq+7epqIeYatd5HUzjmtADdhL1t2uCr7ynPtRifQqCcoxnqyK
    T5EwcgvCz7fgyoFpflvUSflK6MiwG7uwrQIZ6+JJJvkyg7QjQHt26Dx3i5JB2Jjr
    EzFnGq9EjZITNQRrUFT8dSoCr3yuDI9atmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525698949; bh=EKC9H
    x1T0jh65+I2Ny5Z5b1DrdO2aoR3lIvSC0dl978=; b=QzY1MoEDLAvOlNCM+ZNWv
    oDizjTV142eyNTH18mTlULqxcXjyNQvovMteCrK3KvktEHbv7ci8YFhob9v9URnU
    qHs+c+gbQf6sgOcyac5m/aEFBNZggM7dJ/B7BnTClwlzpTGufTvt+qZ9CvV2RsP1
    jbJ29rOpw6peQLIlnpsPG3qc+ia47ccRZfpP14Y8I2sDT1SJcW80F/7zjECvGmij
    i6s37WiIWfkmm8LcOgvdwdwg4fppbaAPagd3tttv0Cok7nJv9I0drikLTMzQ2uQ+
    Fb0ZWARKQdgv3/pNpxNCrcFZyD0mdrk/towvzbgYGsYIE2jXk2FS+b4OkkM7/7XV
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=MBfrSyWK x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=MBfrSyWK x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKVycW98vGOQPCttBKyi6RgIIWJf+uaAY2TsLkw9vW3q5YUP6fZN1pVmQ877HiaaMygar8LhXSoC4nAuWX61Mb7CW4bVxwjB5/i4DFuAUBj4FrY0ZcqZ
    Pq4RZUweL2cwzLAI1K+3r0xLIcHSOaeEZTJ0qEg26pp72jtpogByOpHalo6zwP96h1VUKdj/DWU4v9yPPTm6KAcZ7LV670bTWgZvvC6QQWQ+pFSLEI1q0Qu4
    K/nXVTvb7fNO5w3ZALY5yg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=HHGDD-5mAAAA:8 a=DDOyTI_5AAAA:8 a=wIdvvatbM0frJbA00VcA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 6 May 2018 18:35:55 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Doug Oucharek <dougso@me.com>
Subject: Re: [PATCH v2] staging: lustre: o2iblnd: Enable Multiple OPA
 Endpoints between Nodes
Message-ID: <20180507013555.GA29421@kroah.com>
References: <1525361585-13775-1-git-send-email-dougso@me.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1525361585-13775-1-git-send-email-dougso@me.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Doug Oucharek <doug.s.oucharek@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 08:33:05AM -0700, Doug Oucharek wrote:
> OPA driver optimizations are based on the MPI model where it is
> expected to have multiple endpoints between two given nodes. To
> enable this optimization for Lustre, we need to make it possible,
> via an LND-specific tuneable, to create multiple endpoints and to
> balance the traffic over them.
> 
> Both sides of a connection must have this patch for it to work.
> Only the active side of the connection (usually the client)
> needs to have the new tuneable set > 1.
> 
> Signed-off-by: Doug Oucharek <doug.s.oucharek@intel.com>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8943
> Reviewed-on: https://review.whamcloud.com/25168
> Reviewed-by: Amir Shehata <amir.shehata@intel.com>
> Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
> Reviewed-by: James Simmons <uja.ornl@yahoo.com>
> Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
> Signed-off-by: Doug Oucharek <dougso@me.com>
> ---
>  .../lustre/include/uapi/linux/lnet/lnet-dlc.h      |  3 ++-
>  .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h    | 17 ++++++++++++---
>  .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 25 +++++++++++++++-------
>  .../lustre/lnet/klnds/o2iblnd/o2iblnd_modparams.c  |  9 ++++++++
>  4 files changed, 42 insertions(+), 12 deletions(-)

Always put below the --- line what changed in each version.  I have no
idea what is different here from v1.

Please fix up and resend v3.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
