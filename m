Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-463642-1521526614-2-8796778835133659053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  FROM_MISSP_FREEMAIL 3.099, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521526613; b=XGARvQ2Sa1iGcKZPDGvoIgXgUKXfMBxIq8b/FuEiTRSRt8S
    OqtqDlddttqdG27L0J2lUYAWLDq2gY6JlJXjzIj4qadKHR8tOlG26evIZAUJusxd
    gNPI0n1dupJ2pCLYMpp+1YWg/8rEywI2l7CNIY3p4hyHFiGDGE3BlKo2MVAtSbCW
    9FNzoqs0YsJaiYklswUpvkc5iDOKEFJYPkLs1fkttVuib78oKZ5GbgAGym+s+d/F
    vHHPxEFkRjI5shZKp2dsxCtTeh/qUA5lSP2evSYWqW79xhEyVnT1szt4m/63K/bv
    YODDHfh8hdf1EPd6OpqOBQp3YqQbHPvFmYblZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:date:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521526613; bh=M
    BBx/XIeVZacMzeW/pxffc2LngRRthW2uLQBshUjy7s=; b=V7luQmSHxuWBwjGud
    t3I6fqC+AkbahO/j1gmhByDmcjfSwQcLjfB6GRglIxrDTioRTRtocrckUtohnwy8
    fteVcfb0S9OKKlZhtGWbZxmsFAAgQpyL3TM6zw1tQR1GnSxCblnPu0sDvbjPy5tt
    t6Sbrp/bf/iiRXC+/xecRhfTMcevXYfMQTmxPaooOkOKhgGvB4cHMbtWOM/YV3oo
    ugYkf6HoUnWCKgEn8cz/FJsjiYuse1r6ggBvMc0U5b5DtRlFatEkhy1n6gUoySp+
    CnyxCXOdjBremLmYIwdpk8XxB25ydHrt5TcKyk1m/PV8O1TilaRHVpaV/Tbju/zl
    E2HnA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HKQRLcQ8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VqwsilO5;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HKQRLcQ8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VqwsilO5;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtgv3TbBK4EO/m3Gnmmd1IxTF8BVw5Vx7kYIKPAqcW3zvuTjFHN6v9OFLoUow6K34aMMyE7zA==
From: "<Hariprasath Elango>" <hariprasath.elango@gmail.com>
X-Google-Original-From: "<Hariprasath Elango>" <hariprasath.elango>
Date: Tue, 20 Mar 2018 11:42:27 +0530
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5/7] staging: wilc1000: replace switch statement by
 simple if condition
Message-ID: <20180320061227.GA4866@hariprasath>
References: <cover.1521030891.git.hariprasath.elango@gmail.com>
 <2a46a5cc8ab69c1143c480bbac1f7e921011d982.1521030891.git.hariprasath.elango@gmail.com>
 <20180319184546.GA17337@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180319184546.GA17337@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, hariprasath.elango@gmail.com,
 ganesh.krishna@microchip.com, aditya.shankar@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:45:46PM +0100, Greg KH wrote:
> On Wed, Mar 14, 2018 at 06:15:03PM +0530, hariprasath.elango@gmail.com wrote:
> > From: HariPrasath Elango <hariprasath.elango@gmail.com>
> > 
> > In this case,there is only a single switch case statement.So replacing
> > by a simple if condition.
> > 
> > Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
> > ---
> >  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> Does not apply to my tree :(

Hi Greg,

Sorry about that. Shall I sent a v2 after rebasing my repo ? Will that
be fine ? 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
