Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-138102-1518145869-2-13554267054641754518
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518145868; b=l2KSEo+4fyXLMIy9Zn/YrH4CWrqaXLPtGwQnkJNqjZdc8KI
    PyzDZG4OnWJMC1K9NCmyDR6fCpTq1ljKd+NVldv2gyS9H89Pw5C7w4XKlGTUTt1A
    FbqsmiPUHSe/DxGMl8yyHEfuEJ5O0YR+uXrmt7SP+NacIN6WZX4GFuCgnC1+D0O/
    5exsfeBFuLhNR4pvpSeS7LMbsI+cPvMgAj+lr0ZnuWr72z4mjj92Tp1t3Hrd4U3s
    uh0TCPcKW9h8EbWi1+s7F75AbaG0TW3rcJ0ll5JIp7Vne0WAUz1w1ObqallgxOMC
    bwAko8tsAo2sjJrEM/mlIavSFQgH95DyBPDpeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1518145868; bh=KGqQld579NIaVhWEL7tj/wuZCPs
    lD5FUgCewYkVp/C4=; b=TQDacd9+XP0Nu4Nq17/G0IU917PM5e0jvYYxwBKOaMw
    fEUl8fF0mA8/c7omXObfqXFBELixFbV73mnlsKfoMCJoMFI9JftQTqUCaqBxvgh1
    ldKYUPI+oLkAJUPJnaxS3GdtZgnRjmCxuyZ7j7gVaUwllKX81f8luzeJqj8cTQ9J
    Je8v4idoVihhYWFjbRdRCoV7ixfW2RFU62WVulVucpjeYKvNocdJ6k4saxcFG1o0
    FifM6T73B4qWJ2TalysY/VCaaVvyeRVF023JMtCaBk6wxfvZQ3OeWNQf9fxJB1Pq
    6tVIeEFtIrM76g7zd1BAvLV6Rv7bkQkmmyVIZ43p5oQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>
Date: Fri, 09 Feb 2018 14:10:44 +1100
Subject: Re: [PATCH 41/80] staging: lustre: lmv: separate master object with
 master stripe
In-Reply-To: <09CE6CEC-52BC-4B29-B609-40DE68A64A33@intel.com>
References: <1471378773-24590-1-git-send-email-jsimmons@infradead.org>
 <1471378773-24590-42-git-send-email-jsimmons@infradead.org>
 <87r2pvkkl5.fsf@notabene.neil.brown.name>
 <09CE6CEC-52BC-4B29-B609-40DE68A64A33@intel.com>
Message-ID: <87o9kylux7.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 wang di <di.wang@intel.com>, Andreas Dilger <andreas.dilger@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: multipart/mixed; boundary="===============7630769096972579333=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============7630769096972579333==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08 2018, Oleg Drokin wrote:

>> On Feb 8, 2018, at 8:39 PM, NeilBrown <neilb@suse.com> wrote:
>>=20
>> On Tue, Aug 16 2016, James Simmons wrote:
>
> my that=E2=80=99s an old patch
>
>>=20
...
>>=20
>> Whoever converted it to "!strcmp()" inverted the condition.  This is a
>> perfect example of why I absolutely *loathe* the "!strcmp()" construct!!
>>=20
>> This causes many tests in the 'sanity' test suite to return
>> -ENOMEM (that had me puzzled for a while!!).
>
> huh? I am not seeing anything of the sort and I was running sanity
> all the time until a recent pause (but going to resume).

That does surprised me - I reproduce it every time.
I have two VMs running a SLE12-SP2 kernel with patches from
lustre-release applied.  These are servers. They have 2 3G virtual disks
each.
I have two over VMs running current mainline.  These are clients.

I guess your 'recent pause' included between v4.15-rc1 (8e55b6fd0660)
and v4.15-rc6 (a93639090a27) - a full month when lustre wouldn't work at
all :-(


>
>> This seems to suggest that no-one has been testing the mainline linux
>> lustre.
>> It also seems to suggest that there is a good chance that there
>> are other bugs that have crept in while no-one has really been caring.
>> Given that the sanity test suite doesn't complete for me, but just
>> hangs (in test_27z I think), that seems particularly likely.
>
> Works for me, here=E2=80=99s a run from earlier today on 4.15.0:

Well that's encouraging .. I haven't looked into this one yet - I'm not
even sure where to start.

>
>> So my real question - to anyone interested in lustre for mainline linux
>> - is: can we actually trust this code at all?
>
> Absolutely. Seems that you just stumbled upon a corner case that was not
> being hit by people that do the testing, so you have something unique abo=
ut
> your setup, I guess.
>
>> I'm seriously tempted to suggest that we just
>>  rm -r drivers/staging/lustre
>>=20
>> drivers/staging is great for letting the community work on code that has
>> been "thrown over the wall" and is not openly developed elsewhere, but
>> that is not the case for lustre.  lustre has (or seems to have) an open
>> development process.  Having on-going development happen both there and
>> in drivers/staging seems a waste of resources.
>
> It is a bit of a waste of resources, but there are some other things here.
> E.g. we cannot have any APIs with no users in the kernel.
> Also some people like to have in-kernel modules coming with their distros
> (there were some users that used staging client on ubuntu as their
> setup).
>
> Instead the plan was to clean up the staging client into acceptable state,
> move it out of staging, bring in all the missing features and then
> drop the client (more or less) from the lustre-release.

That sounds like a great plan.  Any idea why it didn't happen?
It seems there is a lot of upstream work mixed in with the clean up, and
I don't think that really helps anyone.

Is it at all realistic that the client might be removed from
lustre-release?  That might be a good goal to work towards.

>
>> Might it make sense to instead start cleaning up the code in
>> lustre-release so as to make it meet the upstream kernel standards.
>> Then when the time is right, the kernel code can be moved *out* of
>> lustre-release and *in* to linux.  Then development can continue in
>> Linux (just like it does with other Linux filesystems).
>
> While we can be cleaning lustre in lustre-release, there are some things
> we cannot do as easily, e.g. decoupling Lustre client from the server.
> Also it would not attract any reviews from all the janitor or
> (more importantly) Al Viro and other people with a sharp eyes.
>
>> An added bonus of this is that there is an obvious path to getting
>> server support in mainline Linux.  The current situation of client-only
>> support seems weird given how interdependent the two are.
>
> Given the pushback Lustre client was given I have no hope Lustre server
> will get into mainline in my lifetime.

Even if it is horrible it would be nice to have it in staging... I guess
the changes required to ext4 prohibit that... I don't suppose it can be
made to work with mainline ext4 in a reduced-functionality-and-performance
way??

I think it would be a lot easier to motivate forward progress if there
were a credible end goal of everything being in mainline.

>
>> What do others think?  Is there any chance that the current lustre in
>> Linux will ever be more than a poor second-cousin to the external
>> lustre-release.  If there isn't, should we just discard it now and move
>> on?
>
>
> I think many useful cleanups and fixes came from the staging tree at
> the very least.
> The biggest problem with it all is that we are in staging tree so
> we cannot bring it to parity much. And we are in staging tree because
> there=E2=80=99s a whole bunch of =E2=80=9Ccleanups=E2=80=9D requested tha=
t take a lot of effort
> (in both implementing them and then in finding other ways of achieving
> things that were done in old ways before).

Do you have a list of requested cleanups?  I would find that to be
useful.


> I understand that beggars cannot be choosers and while there are people
> that are grandfathered with their atrocities in current kernel tree,
> we must adhere to the shining standards first before having our chance,
> but the standards are not easy to adhere to in an established sizeable
> codebase.
>
> Realistically speaking I suspect if we drop Lustre from staging,
> it=E2=80=99s unlikely there would remain any steam behind the cleanup eff=
orts
> at all.

Thanks for your thoughts,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlp9ETQACgkQOeye3VZi
gbm/6RAAuU07NkyPTPW9RPH6hvGMB8Nfq7Xyq4zsFJLlsGzzFK5basR7jV5e3s1r
vRKx1+ee/j9L9BEzLhq6rJ3ZW685jEGltWzjOcS2bAaUST8FIW9zMJKflajD6PUL
jkaQF4wwf2MSR7AuWX72A5kHDwbJP6mB7gSy1236SPthy2FkKCwUZOR6o5Wkij0P
ectAZznRFUwjqxwvuu1whiz43g30+cGMuTy/6riHU84NxkUjvcCunQF0e30OBELU
/Ehz4bNDDZxNBBgBoy37k4WHtEseTyg3KyY3eLADb0quM7T1qgtn7KUXE6pvRS0t
sD2v2FSejw+fMS/WL3CX5d+D8AqfSBuZulIzbDEYzuyMBs92TYUv0YS1CpXGHILK
DULk65UgCZz/b8NlYvtObAiKaE0FrQGbEQMkKrbsIL+++LNHwnExn8gusobmv0oS
diO1liRcNPO67whTiO6ZWYlyvKUgFSTms+I+tERaOCK8KtIvxilnmpIvHvTubeuI
p6u8jOH91wMPlm8qv/6n89TFOyigfmyARftx3G8BN0lP+5MFh+AuO0zE3EJx3Xq4
rT3oAsVJ/5nGJBXbOuq2QdvBZ2nTbWyD9U4yxV4wsAHOveMiuod2ANiP4eIpsLBU
bNWn/kYXpPtiLBRN6STYoTX058AGgcIZDkYNyCec4FRaWcNN4MU=
=pHap
-----END PGP SIGNATURE-----
--=-=-=--

--===============7630769096972579333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============7630769096972579333==--
