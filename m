Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1133588-1524488321-2-4132992986432371945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524488320; b=dMB0bs8gpIgH7f7YXmqOX/wVZSDW6Y+RvUVLH4jOQBHbbQPPKg
    HOyJJHgHUnbDBz9GulPw+ukIfl4zSfYwdP3F8q5032F1mwMae0KaNm6HeIzSVmjb
    i3Gw2r8YhzlnDtdHyBU0TQriKssDCvOQHIxbM2v85HU5e1YRPu2cHBCOO9CLoF3J
    DomJ3odDSirWMXQoA6y7Ug8c4sy1Fh7PPPPuOCVrp1egn5l4qxiX6L6u+TTF++98
    toJDZZUPDJlHJyIDweDdP89NxtLDQvAvj/YaaUFJWTaB4MBkqT+9q+MCONMdsBo6
    ArcOgKaahZQD/5lvW0Ds2WctaJFNsrdkyoSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524488320; bh=Gfumo
    tOmngtsNqdBrbBJQyo3lVsMiToZrmvTMrnlZX0=; b=viGWXQSCmtSDGvKqkCAuu
    XG0gL+CplvD9VSUjxEJoRrnNOFPeNZIrsvkMc1mtOyWTv8TenwNxvKvWLAqEk7GN
    2ePzfHiGMWEZjJNXgYF+2+5OvycNGZc/sMDAvUVm3TgjmHcki5MVCnJZGGHBlxSI
    KJykg69CxRwOQrmI17yNBpNUO7V4aDTy9ob08iJLNgRgCsobP/rHLypiAZOhcQ1U
    uleAO9n7ujXtcBsjqWrH+deh0CnTcl9jl0hsGIBoED2uzJ8sXYcZ9gBHwuWs/8W3
    UWmeOaGVoK6DuJLMQhvpFj9cw6Kp4k7F4GiQe8sZNwRJOVzjbALYKs0kUBTm9wJB
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDFtCEr7A3DIyvSfgvg3zoWV+3i/NkJiyO/oixT5sjv4LB1/zG4BhuiVrr7dV0Df77NRXpV8Rhr+XpiONZ8Z9TMUwm/r3/oV8vzFtaRZeqglYSA/cj0R
    PY7hVuWwSoe8+QWuVJheCePEhxWZMiwZgb6wwkZzyQMKN24XU1qDs55Fs1obIkVE0CzSrksNLmsZw0TIpQvHsJFqshcuJbe0cqHhmqxy2GWjo1qTCcoFhw4I
    UL8yCuGnU0Ij5aham/yx+w==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=CjxXgO3LAAAA:8 a=DDOyTI_5AAAA:8
    a=wqdROaKO76PCPhWBUJ4A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 14:58:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 00/22] staging: lustre: llite: fix xattr handling
Message-ID: <20180423125827.GA32162@kroah.com>
References: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
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
Cc: devel@driverdev.osuosl.org, James Simmons <uja.ornl@yahoo.com>,
 Andreas Dilger <andreas.dilger@intel.com>, NeilBrown <neilb@suse.com>,
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

On Mon, Apr 16, 2018 at 12:14:49AM -0400, James Simmons wrote:
> From: James Simmons <uja.ornl@yahoo.com>
> 
> Lustre utilities and user land APIs heavly depend on special xattr
> handling. Sadly much of the xattr handling for lustre client has
> been broken for awhile. This is all the fixes needed to make xattr
> handling work properly with the latest kernels.

Most of these now applied, please rebase and fix up the remaining ones
when resending.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
