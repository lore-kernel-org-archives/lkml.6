Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-924688-1518044196-2-5152112880139537894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518044195; b=iY5+Jk9bhgXiVhL8Qyr/BQ0EHuum4iXWCkP64So0WX3OsRY
    OynqPU/0PMcRzn/9mDVf4LDLrsqSyKkDbwGzM17tKMcf/ndmd+hu8h3zJzh7a6Iz
    cAe4ldP417c5cnmgpaywIwrhpxX1JgmC8OnbyrylYkmwHDhBxTBmXYnkDLoTstrh
    1ID/+5QiLKWTa9/zcq1NIMPEPaaBSaUko5X3xoMCqVsswdrEltUpZgJZkInwq9Ab
    Q9dIT2VCCCguR7bYpjh+fdJIg+lzdnzYygp+E/vW5s+I+GsJgDSzLNk/Pq/sDo8K
    I5m7f/1Bd1pIXjheaED02QU3inUzJoQNjA7ot+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518044195; bh=T
    /+BrPusMg5PrVPb7CU0p4b+BTX38iHDc4ZkH/nvnmU=; b=Vw6Gw6XoDEqnSHH8I
    wySweG2gAyNt2gU9N+QhNFswXTOBbd4HU4JL0govM11Zxe2tCfxVuiP+njj2QYJF
    wG4O94yd3kEnYOYKhggWavfC4YJ03DYMjBnwo43WH3nE5KhTYzb5bPAoWT051qhv
    ACfJTRa8eANANSBC6l+8Adfm3DgpToy8vS3NfWk6dMwf+FRToP/xgzKI+hs1IfJ6
    JgTxS1UjXL1xYE/0SsI3CfPra5+LQ7t6JtoN9nvEZvpIgmZgET2QX/q2QUVS9Nfb
    /QR4siQ6TN7qNXi+K8nFX6d1niN9+ACKqRI8rk2IUk6O05FUYZ06kQ138P2K/ee2
    e0y+A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 7 Feb 2018 16:56:28 -0600
From: Greg KH <gregkh@linuxfoundation.org>
To: Todd Kjos <tkjos@android.com>
Subject: Re: [PATCH] binder: replace "%p" with "%pK"
Message-ID: <20180207225628.GC10647@kroah.com>
References: <20180207215737.251082-1-tkjos@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180207215737.251082-1-tkjos@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
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
Cc: devel@driverdev.osuosl.org, arve@android.com, maco@google.com,
 linux-kernel@vger.kernel.org, tkjos@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 07, 2018 at 01:57:37PM -0800, Todd Kjos wrote:
> The format specifier "%p" can leak kernel addresses. Use
> "%pK" instead. There were 4 remaining cases in binder.c.

Luckily this isn't an issue in mainline as we don't print %p values out
anymore as of 4.15.  That being said, this is a good fix and I'll queue
it up after 4.16-rc1 is out, thanks.

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
