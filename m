Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1258392-1521546157-2-6516993090593209434
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  FROM_MISSP_FREEMAIL 3.099, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521546157; b=M/5O30IC2q9Z2MTqztjEeeBlQaPqFPOB4SYpZdzKLTdVGNL
    tSwzjmocdlpnHkU9d+rYZT0kv5wDejxWXl4moq36HBUYYmwzgZNN8udKj2uYTQzT
    dVkba5zPTG+2IGpf3rg1Pqa+0kJkuoO6vg6YmWLHEdXz3ivtO8QctpSJ3jdjB7a1
    9fkEF5uaxII79hS3YaCXrDV9fm2PkKAeAjq763OWiyeJOca4scIeXNROMwUD7/u4
    wLdzB4VEwGy5zpmGNKEnc02o8hUTiTWk5n+jaZdata3vMIJrxlEvQPR/EyDMg5y5
    WwAZb2x3dNqIYgPSrAhAdTX6xh/eTNKxCwQK2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:date:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521546157; bh=O
    1mFEPeANLwfDneDRaXNVe2tthYty017RJUGMU7ibW8=; b=tfSko5Lcsn5Lqd3M+
    lJnnoMkASPGmLbqMC0MUKook0bKMsqiKq7WXyWmHArLPDbRWhJQ2DOiUAagvSW0a
    HLS3X/PG/00iofzja8f+oO8mqZ+3zi4WHxC57bjZKf66rAJKnMF02QWJ+HwSISVr
    0q8ngvZhivfEh/vcC/cAP6ZRprzu+N+BOTeiW4w+NeW1h6xmXZBm2Ln8xJupe220
    d4fguwHi9zqzLGpfN92jTf1dc4ahz1kcU2dx6abJMu+Iq/t/Y/92sLvvDBRm7nxu
    lztatKBC/K3m+aUfNoUVRFBeaEIALIQ5IN/8fMNjxN01u24Sf1xzIWPVfK63f/qf
    Voeyw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IJxCI2wh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FhucCJSO;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IJxCI2wh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FhucCJSO;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsBFkjsvinbkaKIfPoYoqslgPuFmob0tH5BQk9zV0f1JHKX9QrCw2wnaIR0Ee2QdOgtOJzbrw==
From: "<Hariprasath Elango>" <hariprasath.elango@gmail.com>
X-Google-Original-From: "<Hariprasath Elango>" <hariprasath.elango>
Date: Tue, 20 Mar 2018 17:12:23 +0530
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 5/7] staging: wilc1000: replace switch statement by
 simple if condition
Message-ID: <20180320114223.GA4033@hariprasath>
References: <cover.1521030891.git.hariprasath.elango@gmail.com>
 <2a46a5cc8ab69c1143c480bbac1f7e921011d982.1521030891.git.hariprasath.elango@gmail.com>
 <20180319184546.GA17337@kroah.com>
 <20180320061227.GA4866@hariprasath>
 <20180320112951.wgrd76pxsu3qgk6r@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180320112951.wgrd76pxsu3qgk6r@mwanda>
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
Cc: devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 "<Hariprasath Elango>" <hariprasath.elango@gmail.com>,
 ganesh.krishna@microchip.com, aditya.shankar@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 02:29:51PM +0300, Dan Carpenter wrote:
> On Tue, Mar 20, 2018 at 11:42:27AM +0530, <Hariprasath Elango> wrote:
> > On Mon, Mar 19, 2018 at 07:45:46PM +0100, Greg KH wrote:
> > > On Wed, Mar 14, 2018 at 06:15:03PM +0530, hariprasath.elango@gmail.com wrote:
> > > > From: HariPrasath Elango <hariprasath.elango@gmail.com>
> > > > 
> > > > In this case,there is only a single switch case statement.So replacing
> > > > by a simple if condition.
> > > > 
> > > > Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
> > > > ---
> > > >  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 8 +-------
> > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > 
> > > Does not apply to my tree :(
> > 
> > Hi Greg,
> > 
> > Sorry about that.
> 
> Probably there were other patches on the list that were applied first.
> It's likely not your fault, but just part of the process.
> 
> > Shall I sent a v2 after rebasing my repo ? Will that
> > be fine ? 
> 
> Yes.
> 
> regards,
> dan carpenter

Hi dan,thanks for the feedback. I will send a new version of the patch
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
