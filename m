Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3984029-1518393024-2-8377594433849237917
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8', plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518393023; b=IuDtemYhv/MqjJVd1m0emsAZOETeY66hhxvs6fiFbJDZH81
    4J9u3mt9IkQw2dKXBaeG6UfpsfKkSPxycKiMcY37KjW5mhXheGL45tD/0DD/eANy
    oeHRT3M7j62kMRMZqEuKHhtS4Z9ZhEV00A3YReaPwkB0mZQimL1b9EczIWR6smWX
    1Cuk6I/rOFcqWPvlFrZxkKXLby652pGnHCUrgJosKalGyQLEBHFBiy2F9cD6B7Er
    rozWOvOaqhq11ko2wzLjqjGsPYTgXBf6b0T96xy+IausqNfQUvm+ccZoyUGqPi0G
    VEn9k+ohBMybNtv649Bxoa5FN4zwutuZXO9HUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1518393023; bh=cscDXDsRXLSqRHKn1/fFWrkIr3U
    q9PZaGDFo3TdbLqA=; b=AtNrXQS1dvdDBWHE+/Oa/LJXzfFnq2+5EOhPlKo273E
    RVrtKUlsmnQOjdqOPrQalwbBbgGchPa10IvO+zVIYpyKTGeuhf336vJ4CPaqUQZX
    14qgFrCZLcaWyUi+ZUWt//bTSalvsKS9hnd5QxFLp5IqbfSAeNo3b4vVADulU/8+
    tPOa7hXOSegr5cWDpiyj2YXSHIz89b6Ft4i4ndsBV38SDAta/Mms+7B0mgT87Oxi
    nATSX/+SZgkKaN62Hm/IWE7f6+L51k1dM8F+wjZ2Q4qQV6UeermpbtuKUohn5HzZ
    U6bdVaBmxob/C9up/nUX7o4zrdEjr/A9jAzYlu9tN1g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>, Oleg Drokin <oleg.drokin@intel.com>
Date: Mon, 12 Feb 2018 10:50:04 +1100
Subject: Re: [lustre-devel] [PATCH 41/80] staging: lustre: lmv: separate
 master object with master stripe
In-Reply-To: <alpine.LFD.2.21.1802102027560.5700@casper.infradead.org>
References: <1471378773-24590-1-git-send-email-jsimmons@infradead.org>
 <1471378773-24590-42-git-send-email-jsimmons@infradead.org>
 <87r2pvkkl5.fsf@notabene.neil.brown.name>
 <09CE6CEC-52BC-4B29-B609-40DE68A64A33@intel.com>
 <87o9kylux7.fsf@notabene.neil.brown.name>
 <FC7E817D-BA15-4D0A-9976-F1343F9B022A@intel.com>
 <alpine.LFD.2.21.1802102027560.5700@casper.infradead.org>
Message-ID: <87eflrrsr7.fsf@notabene.neil.brown.name>
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
 wang di <di.wang@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: multipart/mixed; boundary="===============0777396500746849578=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============0777396500746849578==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10 2018, James Simmons wrote:

>> > On Feb 8, 2018, at 10:10 PM, NeilBrown <neilb@suse.com> wrote:
>> >=20
>> > On Thu, Feb 08 2018, Oleg Drokin wrote:
>> >=20
>> >>> On Feb 8, 2018, at 8:39 PM, NeilBrown <neilb@suse.com> wrote:
>> >>>=20
>> >>> On Tue, Aug 16 2016, James Simmons wrote:
>> >>=20
>> >> my that=E2=80=99s an old patch
>> >>=20
>> >>>=20
>> > ...
>> >>>=20
>> >>> Whoever converted it to "!strcmp()" inverted the condition.  This is=
 a
>> >>> perfect example of why I absolutely *loathe* the "!strcmp()" constru=
ct!!
>> >>>=20
>> >>> This causes many tests in the 'sanity' test suite to return
>> >>> -ENOMEM (that had me puzzled for a while!!).
>> >>=20
>> >> huh? I am not seeing anything of the sort and I was running sanity
>> >> all the time until a recent pause (but going to resume).
>> >=20
>> > That does surprised me - I reproduce it every time.
>> > I have two VMs running a SLE12-SP2 kernel with patches from
>> > lustre-release applied.  These are servers. They have 2 3G virtual dis=
ks
>> > each.
>> > I have two over VMs running current mainline.  These are clients.
>> >=20
>> > I guess your 'recent pause' included between v4.15-rc1 (8e55b6fd0660)
>> > and v4.15-rc6 (a93639090a27) - a full month when lustre wouldn't work =
at
>> > all :-(
>>=20
>> More than that, but I am pretty sure James Simmons is running tests all =
the time too
>> (he has a different config, I only have tcp).
>
> Yes I have been testing and haven't encountered this problem. Let me try=
=20
> the fix you pointed out.=20

Yeah, I guess I over reacted a bit in suggesting that no-one can have
been testing - sorry about that.  It seemed really strange though as the
bug was so easy for me to hit.

Maybe - as you suggest in another email - it is due to some
client/server incompatibility.  I guess it is unavoidable with an fs
like lustre to have incompatible protocol changes.  Is there any
mechanism for detecting the version of other peers in the cluster and
refusing to run if versions are incompatible?

If you haven't hit the problem in testing, I suspect you aren't touching
that code path at all.  Maybe put a BUG() call in there to see :-)

>=20=20
>> > Do you have a list of requested cleanups?  I would find that to be
>> > useful.
>>=20
>> As Greg would tell you, =E2=80=9Cif you don=E2=80=99t know what needs to=
 be done,
>> let=E2=80=99s just remove the whole thing from staging now=E2=80=9D.
>>=20
>> I assume you saw drivers/staging/lustre/TODO already, it=E2=80=99s only =
partially done.
>
> Actually the complete list is at :
>
> https://jira.hpdd.intel.com/browse/LU-9679
>
> I need to move that to our TODO list. Sorry I have been short on cycles.

Just adding that link to TODO would be a great start.  I might do that
when I next send some patches.

Thanks,
NeilBrown


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqA1qwACgkQOeye3VZi
gbmo5BAApGghV6KLAR/6FiZKwEpZANBWJHmEsIZBDbsxSt0SUAlioDBFZ4XGV8zn
VP7uNSdZbtLsEc8TEkJtVN+rKmZ0cCTDqihCvXb5vRI6A1iAoh8tAmcREyXwUCjg
N0EQ9G0migDNruWk+y8IR2GoTBTdBFb0Qng4d48GK9Ki3nxippb02zYn/fXn228X
2etAk36KVw5UW4pkGyM5KF3YFtsGEOtO4T4Mfwwy18ALTiMJXjBUd5zhbp8D6zyW
JP3MzgqDdGb7jsM/5BxvbTvekSjYf4X6KYLRg3NnxK3rlU1Uf6E2CHQPt/nx7bt1
hVQcf00OezuhnOf7wfTenGjA/FwfDwOEbG4cb01MNTOECa1J3bl8lvcZPeicurHF
ASYc/C1KfwEcq9VgJL4b8VHQCVtGa4WkNPM+OZ2rC1Qdmc1HWupA+wCEJ9K2vyWo
WBpXJioI9CsYOaH/3U1EY3rOeQsGmfVv/y6cRZZL8/MVPXlQ0Sry1tmoSj3e2lrm
3ZX8gd0biRYJ7mMJJC6yIQ74nyWHKWmNVupy6U0ohFqtIL+tpy6GY8reQ9qr5tyK
Jh1JhM7hRdtX3wmkredengnX0sFurwCt4zVoV6Op4Sd6J3Z1jtK5fmyGDRCuVUjb
f3PQ/2TI92m/jkKmCyeGM7RMK9jrNc6UKubLRuYhEC0iBx9BqoE=
=ZYEZ
-----END PGP SIGNATURE-----
--=-=-=--

--===============0777396500746849578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============0777396500746849578==--
