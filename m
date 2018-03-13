Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-14183-1520981023-2-718364889251544849
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520981022; b=ETkaveuzftg3HnbRnwP/jPp1LBpOAkLPUXxRp3z7UiUATdm
    Oqid1N5VjnDxYaHUmc+rD7PyL0E00W8Hv1sDy29ixrGKH9LWjXXrMU3hmHO1ygP4
    zg14tyvavBPPcBuKxma95XKU3YAsmAzeQPfR3IyFt3tDxbGLl01lUM4ktO/VAhfC
    NDHAbf9Ulj3ad7/vzIGGZI5+OMblbEmUdmkZUiBNsbzDltnDRbWRj4CEOoGYnt3g
    lXo8XrAtsCzP/nK96El8R67f2yHRzhMjwz4nHski39N0MW3+1c4D1XxJ7gyEOOtK
    HWAtlEmEsT01vgDYdKD4JF3L0vgeKrO4AiIhxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520981022; bh=5
    rsAd9eaf2HvV3g8jaOT6u0s0V/LE4VF8gx1d2zdwuQ=; b=Q2MDZ9Mlr1Ngoziwr
    zM/viH9zmQZeSvuJIJXA+iBEX3DVLaA9sQwakkDYPSV+GIMbG8t897NSopCOShXM
    j/6EgqGJU+SvVejxQXzlzcnwmVY6W5mtNT5rBGPfLW7OpDlom50R8wFl2Q4xoCv3
    w2++eBGu2nwGfE08D9Po1RXFzt/i1kCRMoaQ5Y+93+TlbekGax24yUFZ27NSFJ08
    1bnh+T2IVRDNE/edU7EvNGsFATrytS5sWIudw4sa1GWaTjguEfVczRcVNvwV24Hs
    yZB2cy8cFiUcVd4y9j41q7fWFkqzIAStmeTvk3i5V5WM8hNPitm7HNaS5HfSrkNB
    nT22w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Mkhrc9Yq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hN0t9kYf;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Mkhrc9Yq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hN0t9kYf;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELu2Wl/jXVPU9mFMXo1OA4rlgAMbUPLisoOW/Dvl35sYSpdxVeiJou8mD42SWJkVwKrgLf8Ts4aNTkJeO6yCPUk=
MIME-Version: 1.0
In-Reply-To: <20180313223405.16627-1-ps.report@gmx.net>
References: <20180313223405.16627-1-ps.report@gmx.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Mar 2018 19:43:32 -0300
Message-ID: <CAOMZO5B2GxUdRmxFfi0Eamfv65DfubQf4wrpX58GCJ-2p-gtLA@mail.gmail.com>
Subject: Re: [PATCH v2] media: staging/imx: fill vb2_v4l2_buffer sequence entry
To: Peter Seiderer <ps.report@gmx.net>
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Steve Longerbeam <slongerbeam@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Peter,

On Tue, Mar 13, 2018 at 7:34 PM, Peter Seiderer <ps.report@gmx.net> wrote:
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Could you please resend with a commit log explaining the reason for this patch?

Tahnks
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
