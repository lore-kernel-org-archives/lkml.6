Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4106523-1520978225-2-5020975921830730800
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520978225; b=j4K0n198sqkhlspzxJcyIgSf5DvgEYDfQ97kzJP4yK4c+hH
    lkSbJ9C9/CxlOY6hq05DR7M0xwWRetw6mTHRQphLDfVfPRvOrWPWCuv4mp4UMy5X
    ixq2CcrF5VTEfXaBl83kN859NdrEVQavuSpppVmwz2DmJtseMP6z3rsxMoikAAvN
    Pv00EmWVdcWaAQR+Z2D5ljB5EU6VpQMBpzMi+TdbuvqHzFHIzvp0oWn7XB2PYFvK
    FQrTs9ephn/HXfMBkL6frzJirwE5UTGbJp5OaqWPuQY3e/V3ImjQAiR68/WCibyh
    GcjFjM7PtBMxOPOYhpHNevb7y4SkPd4VZNkuEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1520978225; bh=brV5aPeXp/+bdSZeQjDclmSeQ2Z
    pvVvVOCYlYzAMxVw=; b=wg42p6gdAI2EMvamZzNBNfPL82US7cOAKWILKr0pHS9
    I05kvTatADGFvlfqXd2S1U9mAaRp/xMx6HElOzB6fsGt2dvCYGWpumpZ81BGW5mR
    KidmGpnEFcqjSX2gi9GYxb6KqJtZhnpcvR7ioNyHJmhfflrENN4jRlldEloHcMMM
    n3zpcpgApLnlw/2nAUyt7zAtkzur8+v3OyHT445/nbmjCaPeGKWUsfmKXf+iCtTQ
    /b7lGzXSxcZv5rRzJrDBbBRSi+pF59RiXrcFYw7kMkE8w/4ASsmvbEQ2kVe4W0Ov
    lvTC1nNVLVwdcX3PodDo7NU/tWPCHX+gIzdKXNDtTjw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: Arnd Bergmann <arnd@arndb.de>, Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 14 Mar 2018 08:56:45 +1100
Subject: Re: [PATCH] staging: lustre: use module_name() macro for debug printf
In-Reply-To: <20180313130425.3975930-1-arnd@arndb.de>
References: <20180313130425.3975930-1-arnd@arndb.de>
Message-ID: <87in9zd4gy.fsf@notabene.neil.brown.name>
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
Cc: devel@driverdev.osuosl.org, Aliaksei Karaliou <akaraliou.dev@gmail.com>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 lustre-devel@lists.lustre.org
Content-Type: multipart/mixed; boundary="===============1755472846114048386=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============1755472846114048386==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13 2018, Arnd Bergmann wrote:

> We now allow lustre to be built when CONFIG_MODULES is disabled,
> but that causes a build failure:
>
> In file included from drivers/staging/lustre/include/linux/libcfs/libcfs.=
h:42,
>                  from drivers/staging/lustre/lustre/obdclass/lu_object.c:=
44:
> drivers/staging/lustre/lustre/obdclass/lu_object.c: In function 'lu_conte=
xt_key_degister':
> drivers/staging/lustre/lustre/obdclass/lu_object.c:1410:51: error: derefe=
rencing pointer to incomplete type 'struct module'
>
> This particular case can be avoided by using the module_name()
> macro that was designed exactly to handle printing the name of
> a module in all configurations.

Learn something new every day :-)

Reviewed-by: NeilBrown <neilb@suse.com>

Thanks,
NeilBrown

>
> Cc: NeilBrown <neilb@suse.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/lustre/lustre/obdclass/lu_object.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers=
/staging/lustre/lustre/obdclass/lu_object.c
> index 8ddf23b82a2c..3ae16e8501c2 100644
> --- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
> +++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
> @@ -1407,7 +1407,7 @@ void lu_context_key_degister(struct lu_context_key =
*key)
>  	while (atomic_read(&key->lct_used) > 1) {
>  		spin_unlock(&lu_keys_guard);
>  		CDEBUG(D_INFO, "%s: \"%s\" %p, %d\n",
> -		       __func__, key->lct_owner ? key->lct_owner->name : "",
> +		       __func__, module_name(key->lct_owner),
>  		       key, atomic_read(&key->lct_used));
>  		schedule();
>  		spin_lock(&lu_keys_guard);
> @@ -1547,7 +1547,7 @@ void lu_context_key_quiesce(struct lu_context_key *=
key)
>  			spin_unlock(&lu_keys_guard);
>  			CDEBUG(D_INFO, "%s: \"%s\" %p, %d (%d)\n",
>  			       __func__,
> -			       key->lct_owner ? key->lct_owner->name : "",
> +			       module_name(key->lct_owner),
>  			       key, atomic_read(&key->lct_used),
>  			atomic_read(&lu_key_initing_cnt));
>  			schedule();
> --=20
> 2.9.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqoSR0ACgkQOeye3VZi
gbk8jg/8DWxkF6SXJ6X9TbEAskcsaaY9YQQNED6ocVUC+dcBtXmvchgYwEpfVqiI
uxmfSkl7dzlMtVAsQz8hif/LOrZ9SbpFJkV0fMywBJnjvLvoSWzEU3TjbjmSrBm1
1uiIVO38t473XF63dXTGFlwhGMiLsfoVNFUJZVNUyhHl0ugfJ/vySWlOpe6hxkr/
RW9RVEmP6SfASNw+AEl2Wq5iaZdfeO58btEWTav43UdIoOrljzHFzRT9rxRFD3V1
qzq/QkEsqG+/OdZTBiY29HqkBSzdf7iVY4rSobwRq03d5XypJ4JgoP7Nx43QwFHp
fSIJm1IPneMYzSEvJaHFCc0xC29is+ekD6C/msVJfV/LIMkRXgVjHZu74uC7vuFv
40rIv95SvxfL/lcR9oDdpOF4hPofERLr26VolFMlHhzlv8+p8b8QE5jTIuTOMHR4
xoQsgZgUfhxbKyQiejsjPLClMq+yGxQpg9/uvx7puoz2Vu5jBxi2zbkih9TE/M/C
p+NmOOkP1s1svkNIQciTHfi9to20NkErHHbzTTOAupSjYvGfpzCkRSSfbHxE9Ls6
c0fUM7UywZLC9OMoFExerg3DwruwJU38cPi8mhYQiKxw/a/3RbUX3+5hCz+o0oa1
5EhxCLnnMW8UrYNR1hpN0/wqL6sBpZ31jvO6jd0/lePNo0nvW9Q=
=ba3u
-----END PGP SIGNATURE-----
--=-=-=--

--===============1755472846114048386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============1755472846114048386==--
