Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1445372-1521817097-2-10899973508013809914
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521817096; b=gFTrjd2CuJiysYmaz+SVbzuNCUPJpcBAcBZ5QlKi+I3LAHL
    WamK9A1ST6mJlCL8XHLZ3B0Oi/3+IDcWpyryF5r5n76/C/CIaNzN5bNRLc6EiN6W
    Si9zxZcfSvgDiIwkql9rKamWUX4q3uFu5XISGvs0+SxE6sKPsKPJKWihVRWOfwKl
    3hmudVU3K5m2ZpM1rIvETaOo7/kMgqW+281pqJwMUKq+sFT2LaeuJAKlHfZfFn6K
    3M38dmNT+glxABjDp2pk0ctj+YUAESXeiKYswokLWiVQrRGL071zfPpVCq/8wnTq
    6hTiJJDAXq8Qt0LmCRXudJdpwCCZ7143p8Mh2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521817096; bh=Y
    V8/YOyPMQJLcy8g2yx/pE8jdOh6dulHOfOYfRBzjU8=; b=nLwwl80FuFsPc9DWT
    XP/5/eb+H6RO2sJRmlOTSURG16aVyftC4IYLtY+YPM9rgyHrrwEnX9u/H3mG6SZN
    7Jj10f2iNwnc1cA57hgcjH1JcckpL+Ey+D1lyXAM4e3gNKc026hFJdow4bD1mSJd
    Anpi4NG5XpmbMl0ekn47o/5exro+uRUjr/HCVkRzl4utoMxeY35DmLSxy1LS6Myb
    IDlkMio7zl2rh/rBevlcxSMb/WCCAhVrUexTkT2w7ChMoCYlHo4iDgA2Cat4HQDC
    lTebkqjte1PkIeMy4X+bRIx2UCf/PPuVytg9ArJcXig3G7xjwGza3uGDxg7Xc2JM
    1TlxQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 23 Mar 2018 15:58:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH 3/7] staging: ks7010: Factor out common members in
 request structs.
Message-ID: <20180323145807.GA28429@kroah.com>
References: <20180322172014.GA6801@kroah.com>
 <20180323050745.28903-1-quytelda@tamalin.org>
 <20180323050745.28903-3-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180323050745.28903-3-quytelda@tamalin.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 10:07:41PM -0700, Quytelda Kahja wrote:
> Most of the request structures defined in ks_hostif.h have common
> members:
> * __le16 phy_type;
> * __le16 cts_mode;
> * __le16 scan_type;
> * __le16 capability;
> * struct rate_set16_t rate_set;
> 
> Factor out these members into a common substructure of type
> 'hostif_request_t'.  This allows a large portion of the request
> initialization code in ks_hostif.c to be factored out into the
> 'init_request' function.

The "_t" suffix of structure names is a hold-over from the crazy typedef
mess.  It's not needed for new structure names at all, and really needs
to be deleted from this driver.  I'll leave this as-is for now, as you
are just following the standard of the existing code, but consider it
something to change in the future.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
