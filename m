Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2795102-1520935101-2-7518077947740544092
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520935101; b=k3+IW3noyv3W+M8LSa6jNAXiTftu3h8Y3Wj+xbkA5RDOete
    gg1G7UedoLtzPcTTyGKcp5XDZxDdzS1CpPDK3HoxQhYM2J+NXyhlTXhY5WymxZPZ
    Cs+NN8baiywsnhiacTUVuinJ3WZuGK8+v+xq+dmZO9yEGyRcae8e9BRKFqAEP3/l
    BGcKcdwDmEKiLek/zEpOQFUB0bOCnhXuKgsxvyPEBwc2BNhzqdchZWgn7zmdcc43
    krZqZbR+qVp6k8k0OFLCKoBti76ZlHnH5pHl+RUbmstOTSxe1PTk0qj3CRB8AFR1
    Z7MqSEw+Pv21hs0ydybptUWxQq0PmlyYQFpYeWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520935101; bh=G
    CR3bO9eA22TUu/Isrq9qb9n2P8rlJeFR9h41pe0ghw=; b=s1LrYMxwEQgP4fOwb
    qIho+k0TSo+aAIvdbMCeHrcTvSv1dkaM5tCFfw865zI/xBSPyBItbS2FLF6+hHVG
    k0FtbhbmJ+0bMZCTh+l/ZTBNKuul/Fkkd+XsRgSW2YWxTBOxfBW8zdMhtu7l0vDv
    WVWLcJ/cR3aT7WpB73heeZium9hfY+h2hz9Xb3FQ29xVldB52uwEt33eFjeItVZ5
    sUuCmsy/OPmHehJ5v1jYW4NhaEY4cozrH4XcgkKC84aiagEATMvpUQDHJjqTaloy
    V9JslO0PjbYM9XrQUHHKZogbiHAzWnDLhdWd9DcerpqUtloru01rTgtuT7wv0n+y
    X8Msw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 13 Mar 2018 10:58:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ajay Singh <ajay.kathat@microchip.com>
Subject: Re: [PATCHv2] staging: wilc1000: use pre-defined macro
 is_broadcast_ether_addr
Message-ID: <20180313095816.GA1656@kroah.com>
References: <20180312093903.9147-1-hariprasath.elango@gmail.com>
 <20180313130051.43b087dd@ajaysk-VirtualBox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180313130051.43b087dd@ajaysk-VirtualBox>
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
Cc: devel@driverdev.osuosl.org, vbabu3@visteon.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 hariprasath.elango@gmail.com, Ganesh Krishna <ganesh.krishna@microchip.com>,
 aditya.shankar@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 01:00:51PM +0530, Ajay Singh wrote:
> 
> Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>
> 
> On Mon, 12 Mar 2018 15:09:03 +0530
> <hariprasath.elango@gmail.com> wrote:
> 
> > From: HariPrasath Elango <hariprasath.elango@gmail.com>
> >
> 
> Please avoid use of 'From' tag specially when there is only one
> 'Signed-off-by' tag and its same.

But the email client isn't putting the correct info in the email header,
so this line is needed.

And if it's redundant, not a problem, git handles it just fine, better
to be safe.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
