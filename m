Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1062290-1525698968-2-15190722815196955193
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_06_12 1.543,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525698968; b=Fv7EAK4aUz//1grXGU/z/TSaAHgZ415UF5O42Fb0D7dgUu9ZRx
    GCAtt3Q1VJdkcQa2dIIpKNc7gg7aRhMBQNZdlv+BrJ/kvtcLAkaykNplLyA0KfpU
    ZJlqKUSOsZX1OYra+1HZIAd9MMJvzgwBBuDjFNEZc6q65SZ+yMic74mxB7+yH148
    xzTqFRMDqyoP3Z5tLDiTkb4zDWQY654ZwNaXc/m/IZMdHFXXIw9qUCO2ZKaMVA4q
    RrAY4ihFT3XDfN6GuViiVKR30ZS8aaf1KXKCrrjvibC2wMFLFYCXTt/3bXPgLRAR
    o7zFZnLqca0N3YCOaeV/m5KGFWJan9DtqLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525698968; bh=nm3MI
    F3kmtNY9gsG65gxualYFhTovOz57h2oeqevY1I=; b=ECCrgrgbIZXkH4qu27hH1
    w83PGkN2HqmORPpgQijlofJUZLduUmJWaYoTmhDhVWIClF4FzrZ1K4gZqFkUicC5
    2GcLoGOxyGusgk9XRLjyB0oTljn+AqPX35DRxzrn3VCEYjaWJ6WbktkQABu5okbF
    fefSG6tS6IHWBKx/dMteAwH2tFBXFNqQqtSghMn/3Hwlp2gYOlfwRqVSiRhIyCPC
    F/JahEIZBCq4rsFIh7hP4nSOZ6dF1WAgx6gBlG2nRtY/rActk8X7EeKtsh1M/DVr
    WlO3cCmow9g1i2JJxL7MCRuv/6Jcy0nYoJ9gfWLT0UWCorH05H4W8FDm2VBzgFwC
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=XXMCGL9e x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=XXMCGL9e x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHPQu7giDIWU6tnBbKka84jv2YiB6GhnIj7t5HA4qEaxpEcQLNzj4jYe1zAroMOgrQTU7VMp+bU6HQJUJGKYPbBiGXL7fHOzS6UD6ZIMGlhxZ+U9rfvW
    BTv3tAx4vLznkiKy+CC3kezFyUoqqglLxgg7q28+6lTWKPKX6F1/p857SGuvtcJcS3Qd7qmPy2KlA80CaHyY+cRXAQ2ky99piANaUNvCXDVvVvPOrSJhr/h+
    X6t9htRbQGAvUFF2qJzH7Q==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=UNxZfnvGYW_WpBaSeWAA:9 a=CjuIK1q_8ugA:10
    a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 6 May 2018 18:47:34 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 4/4] staging: lustre: obdclass: change object lookup to
 no wait mode
Message-ID: <20180507014734.GA7146@kroah.com>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
 <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
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
 NeilBrown <neilb@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>, Jinshan Xiong <jinshan.xiong@intel.com>,
 Lai Siyao <lai.siyao@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 02:21:48PM -0400, James Simmons wrote:
> From: Lai Siyao <lai.siyao@intel.com>
> 
> Currently we set LU_OBJECT_HEARD_BANSHEE on object when we want
> to remove object from cache, but this may lead to deadlock, because
> when other process lookup such object, it needs to wait for this
> object until release (done at last refcount put), while that process
> maybe already hold an LDLM lock.
> 
> Now that current code can handle dying object correctly, we can just
> return such object in lookup, thus the above deadlock can be avoided.
> 
> Signed-off-by: Lai Siyao <lai.siyao@intel.com>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9049
> Reviewed-on: https://review.whamcloud.com/26965
> Reviewed-by: Alex Zhuravlev <alexey.zhuravlev@intel.com>
> Tested-by: Cliff White <cliff.white@intel.com>
> Reviewed-by: Fan Yong <fan.yong@intel.com>
> Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
> Signed-off-by: James Simmons <jsimmons@infradead.org>
> ---
>  drivers/staging/lustre/lustre/include/lu_object.h  |  2 +-
>  drivers/staging/lustre/lustre/obdclass/lu_object.c | 82 +++++++++-------------
>  2 files changed, 36 insertions(+), 48 deletions(-)

Patch does not apply to my tree :(
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
