Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3815945-1522157873-5-2525506991949522697
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='ch', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522157873; b=hOltDftzyBVnCeZdr1wFC3bZ/jwyJcesCcsrZsYj72a7hZm
    UMfV085OuP7KOdn0aesSB0Tvy/9XJuFxZzySzaH2K+AA0oIL0PoTXUl6bRfcUR4T
    wuwv5vCgtoFYOHSVhFKyJUP+2S/7V135DzEi9nJCY5ADna6cBlKbABKeRih862fh
    WgXLifz7fxED8JabHclfMtDYMZWTI1QKC9NcF1s+CGYyym61lrKhxz5VvyTv4qEC
    m8RvLnG90HHQV8cmIRvaMq2O1XuLLBnKVEpCKq0bE+yDFVerIJX71bqwqKNBMwcv
    tzJRHYJxWRqqhPXHc1hwTD5emzlh6YjFogvUyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522157873; bh=2
    s8wYyCcRcjynbSSAannFdUvTEtV9XAEfd3fmLgQ1vw=; b=IABnz18bTqY8NFass
    ST/H131Drhujqy9SrieKQxODM0NFKnsvUXTK5SoLOU6/PCvmHYHkPAUHtvbg7Vhv
    hyxT1M2tm0qxVc0ra7ySAgM9+QTL1HKzavCarKj18w/UM8QppTKqQW//WHQQTUZD
    Z3+iSoF/jlBJ6W/nC+ktRLviSZEkfOy/OZYjjEfrhdaxLKELi8ckmAdoeJKFRHkn
    OT8CF1N6rQU++ymYQfBVAgPNdIzpJo4u0+70yhKAcPlsmuvE7gSzrAXvNRC9FmCO
    Fg8SEhWXJrD9zo9QXFR2R5MUbDF2sAANpETwgynVYFepkYbtWvQNfW1AieKAfhbF
    tBQyA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=x7lzf6wI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=x7lzf6wI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBGuxJ5ibP6u55VMVgkC/abdENidfLP85eZkOd6LMVDykphi8pmnZx5/WPYP88ydEX8uH5G3XCqOI2jmcn92tIskj0FsdVZFotZx1S71SU25r4RB1jR4
    emcd4b7aiOHFpIlbBQS7nk5Zo1Q27IKfH/G4Yob1suX4LlG5EAZCgmS8pU7ULtMXF6D6j8p1h4NOuwXZz0cBvzkpeF3Vx9hRyG34VQ7c2gL68H72LYfmoLmn
    ukDTJzqc9S2eJb2BzLx7Bg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=qqGhdLRWVzH9_QHPFfwA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 27 Mar 2018 15:37:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Subject: Re: [PATCH] staging: fsl-dpaa2/ethsw: Fix TCI values overwrite
Message-ID: <20180327133740.GI5862@lunn.ch>
References: <20180327131050.30581-1-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180327131050.30581-1-razvan.stefanescu@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: devel@driverdev.osuosl.org, stuyoder@gmail.com, gregkh@linuxfoundation.org,
 ioana.ciornei@nxp.com, alexandru.marginean@nxp.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 08:10:50AM -0500, Razvan Stefanescu wrote:
> Previous implementation overwrites PCP value, assuming the default value is
> 0, instead of 7.
> 
> Avoid this by modifying helper function ethsw_port_set_tci() to
> ethsw_port_set_pvid() and make it update only the vlan_id of the tci_cfg
> struct.

Hi Razvan

It is a good idea to explain acronyms, especially for staging, since
there are patches for all sorts of devices, can you cannot expect
everybody to know network specific acronyms.

By PCP you mean Priority Code Point. TCI i have no idea about.

Looking at the code, i think you are changing the flow to become
read/modify/write, instead of just write, which is overwriting the
previously configured Priority Code Point?

Please try to add more details to your change logs, to help us
understand the change.

	   Andrew
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
