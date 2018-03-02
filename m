Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-229752-1519957280-2-17574274167911199343
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='cc', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519957280; b=wldHQvsRob8dImEwLyboic/k09WlTKfHdog00Rwy3YmCY2j
    bVdh5xsT3zApSc3u9GYHlutL5uKxHdKZkZeXzow8htsahFxOrU7vARz+vj8yV+RU
    0XKkTYx5gqzfBwAOaYLZ+ZirssA3gAztjGaVsX32VjigrR3DdIOmYgUMIQ1HXnVY
    P2NwqxmnfhZddTlrU/3UMI7oRBCsop7eheFSL0Umzdn2poJk4Ngk77UY7CxCKJwT
    YEZ8f5+hoXcRxq24jac/ms7zFIrY7HZDTAbfA07Zs/vgDG0KUwtsAAuQzfSXH69T
    huA3axcGQFsCyFL45JvglJghduf1Me5fpmj152w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519957280; bh=V
    HteR6JwzfcVN351nkx+Nz4H3cKJojX/cVbh3c2B7xc=; b=l81C4zcQM+sSsu/Yu
    a+2k90gjWCilbhHgkxdsHsycPBoGC+OFqpqaO1doLu2qahaPg5CWq25Ar5DOD0go
    A65fCYDttY1kWy70FpTw9Otq55x/6Vrih9sIuhFylbcdbXxq1yHFW2nUggNKbsuB
    TIQBfb1RmqMnZNbQiJkVkcj7b2UIASe0SYEEcq3QtFjLeHmbJa0hwioZtmBh4ZmS
    QNTG2bxyFudyOPyVkgUANjRvz//G0AiQDZxu/D1iWmLf2h2XYgsGu6lQskSJC74f
    F0Uf38f8T/DeLTE2MrU/odQJp2mjLiRrKmNABpd1AQ3j2E/L0+8qGH15e1AGnp5v
    pREng==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=UNpCeJQ9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=gS3Moe7R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=UNpCeJQ9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=gS3Moe7R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Sender: <xms:FbWYWhTHp3X2YTbnUZNNusggEKZfTzrF66XG5NbCzovUaSxMpFaQoA>
Date: Fri, 2 Mar 2018 13:21:06 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH 3/5] staging: ks7010: Factor out repeated code into
 function 'ks_wlan_cap()'.
Message-ID: <20180302022106.GJ15198@eros>
References: <20180301051911.1314-1-quytelda@tamalin.org>
 <20180301051911.1314-3-quytelda@tamalin.org>
 <20180301063721.GD4059@eros>
 <20180301111500.lxge4yqfyi2najt6@mwanda>
 <20180301205436.GE4059@eros>
 <CAFLvi239G_PpzUtzV2W1pi5fW+N-KW_W2O+h_-fTfv=-FwdDCg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFLvi239G_PpzUtzV2W1pi5fW+N-KW_W2O+h_-fTfv=-FwdDCg@mail.gmail.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, wsa@the-dreams.de,
 Greg KH <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 05:28:26PM -0800, Quytelda Kahja wrote:
> Tobin,
> I understand your point, and I've read submitting-patches.rst.  I made
> that wording choice because I was looking at some older commits that
> were worded like that.  I'm fairly new to the kernel workflow, so I
> was just trying to emulate something established, and it sounded less
> stilted than my imperative attempts.  However, I will word my change
> logs in the imperative as best I can in the future.

If you master the art of writing commit logs let me know - I'm chasing
that elusive goal myself.

Good luck,
Tobin.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
