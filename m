Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3036136-1526000019-2-5576664776666222619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526000018; b=IbKwg1+CLa27HbBmHHgq2jZh8C9+fBQSLrTzsE70J1oAz/6oXq
    tXVmA4odwq0fW/U55LDRCid+m3yscOu+HsBpuKdqoo3mE/210uot8dRA0ADnSB5X
    EJisHJV40nEOLeJXbtbBx+pmc2JcAZFnj5aRDEJ8jjGc1zsNm15Fcl+HNVvNlHsn
    sLqCa8tVFyeYurfmo6OI16Ce/XftGT9UQxONiN3Qo8YvtjH6Z/XvfA27uk+HonIL
    1zYkxkElxrhbNNAaL9fmOJYE8A5SGR24pxQqHoPrznGH4fPcrUoI3d/shmrfafMe
    uu6ASfDpx1tI1qrFBryl02NuydmpmozCUdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=fm2; t=1526000018; bh=LjM7/fp/X42dIu+2K3WkoiKI2h/nNOa
    KU8KD0GYcWJw=; b=PeoFBn8jO2WaTwW98j8T65dfgXU4R3cEHVLYQYsQyje8CZf
    pbUdklno5qFVDrA5Cm40RN9SRoBH7jp4Al7vj3Ic79zcff+LFOoY70/6+Lge2P9+
    eAOuBB+j9JMpPBNwK+m5D0KpRDdYK3lE+wUSY7x7QilJkjBFSm8DPVmGHuGXNaNO
    tuQ8p45DXVbtzDum5oMvuYkucOJIAHz/Zh7OvJzsXh6CWHlGxzxFo0reEqoeAlHF
    z7T5Bk1Ova68ETKjr1nStvV6XpTyh8J3+0CtFoVXhlpuFL1RGOqm/XfCEUTz+Viz
    LmIQtsxoW3RZdORXgy/QUctT1nOh5HhncCQmUvg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=suse.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=suse.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCFss5JAlDrC58aqCtfZlVOR7VSqGdF7d7Mv7ZiEnXUM2Vn2RR5hGoxCiLtu3F0F4J2axgZMFu2/fmYibUDLQ8Lwi8SZW2ab03S+RiMUb1ELIM1vmBTL
    HTTh/z3Z0+2obY2BR3tvX956Uv1LJcmDhtUN5/P2J1w8nt6psBp6VT+mmEYOtvbHU4b+EvsI0U4OK1HuP2CLvTkApDldj4prURuirof2wpoy9PkloU35z9MY
    lGWxJQhwrVweANzOqqUaPA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=1oJP67jkp3AA:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ZZnuYtJkoWoA:10 a=QyXUC8HyAAAA:8
    a=HHGDD-5mAAAA:8 a=iox4zFpeAAAA:8 a=sK_hXKufAAAA:8 a=agPvhSWLAAAA:8
    a=cesOdlJX4gxEqhGELAEA:9 a=6KvE7vS0GrlPUjw3f2EA:9 a=ONNS8QRKHyMA:10
    a=DDOyTI_5AAAA:8 a=w27ZC7bHMYj9Vt11HkIA:9 a=CjuIK1q_8ugA:10 a=pC-h2on8RWMA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=yWjlxG-dkHreuWcaj4iL:22 a=OFV2l2Cw3rRTRwl-yjV4:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: Doug Oucharek <dougso@me.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
 Oleg Drokin <oleg.drokin@intel.com>, Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>
Date: Fri, 11 May 2018 10:53:19 +1000
Subject: Re: [lustre-devel] [PATCH] staging: lustre: o2iblnd: Fix crash in
 kiblnd_handle_early_rxs()
In-Reply-To: <1525930679-15227-1-git-send-email-dougso@me.com>
References: <1525930679-15227-1-git-send-email-dougso@me.com>
Message-ID: <87a7t79fnk.fsf@notabene.neil.brown.name>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: multipart/mixed; boundary="===============0294844328859297422=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============0294844328859297422==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, May 09 2018, Doug Oucharek wrote:

> Under upstream staging commit 5a2ca43fa54f561c252c2, the list handling
> code in kiblnd_handle_early_rxs() got changed to list_for_each_safe().
> That protects against the current thread from deleting the current entry
> it is looking at. It does not protect against another thread from deleting
> the next item in the list (which the tmp variable points to). The way this
> routine holds then releases a lock opens the door to other threads doing
> just that.
>
> This patch reverts this commit on this routine.
>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9886
> Signed-off-by: Doug Oucharek <dougso@me.com>
> ---
>  drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/dri=
vers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
> index 32fa8ca..6148fbb 100644
> --- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
> +++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
> @@ -1965,13 +1965,14 @@ static int kiblnd_resolve_addr(struct rdma_cm_id =
*cmid,
>  {
>  	unsigned long flags;
>  	struct kib_rx *rx;
> -	struct kib_rx *tmp;
>=20=20
>  	LASSERT(!in_interrupt());
>  	LASSERT(conn->ibc_state >=3D IBLND_CONN_ESTABLISHED);
>=20=20
>  	write_lock_irqsave(&kiblnd_data.kib_global_lock, flags);
> -	list_for_each_entry_safe(rx, tmp, &conn->ibc_early_rxs, rx_list) {
> +	while (!list_empty(&conn->ibc_early_rxs)) {
> +		rx =3D list_entry(conn->ibc_early_rxs.next,
> +				kib_rx_t, rx_list);
Should be:
                         struct kib_tx

Otherwise,
 Reviewed-by: NeilBrown <neilb@suse.com>

Those "convert lots of list_for_each" things really do need
careful review, don't they :-(

Thanks,
NeilBrown

>  		list_del(&rx->rx_list);
>  		write_unlock_irqrestore(&kiblnd_data.kib_global_lock, flags);
>=20=20
> --=20
> 1.8.3.1
>
> _______________________________________________
> lustre-devel mailing list
> lustre-devel@lists.lustre.org
> http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlr06X8ACgkQOeye3VZi
gbnQrw/8Dk5jFBCdAtfi0FLWjUiZRfmNfbFvzBB3Q1kTM6l+mfAGxYxeNAQPvSs4
ABSnTouhg9tm+gUaq6dbCRV5An+RxhRN8YOsnjv+Az8f7dxD1FLQZTkFLexdvtt9
8y2b+/j6ybteYEbqiPZc7LCvJP8qnAJVrmfveGLyE+KsJV/fySQFPCZ0hlmW1Thl
+GmDBz/5CVw62P7ScguR4U/ry1MyDUZEWq2Dc1MWXie/qPXr7dgp1lab6W/Lq7LP
A4AVnxakg+MUwUEIu/B2NPw7Y46AXK/yMTrk5jqqG4qAQEpgVsp4yO7V4n1fyVM4
CeCqE57EBjRaDCW3iRUSo3kLIS4aSrkGDfNLuY2f4ufr5A19xrBUP/eSZIqkRXa2
LuTHehUbeo3GnAPlFGyvJ3RkFp6ecWiBvQJ2ZwkK5n9qFABKpCQQjAN0D3+FVrah
Hjm+zjZPIJUZ+wilJQ+IDKfsUyzuCJBuKcuGx2AN4gwx7ZfBk0cbQ4Oacq6kIt14
7FojfF7J4CHEGkVzkjLUVA/xM9YW13jAhOvyNvked0kHdSAzQIcXaBQ3mkGohg/W
Dvzj3eXdhhyuQkRtAivoR7Ic1uE4oYl7HXmzoZ6pIysryE5ga8cBuHBbf6bS8Rkd
SNY8BQboH5FxCHVDpjQPtgmc5iC9MEn76jbwaouLkKCX+aXFtTs=
=I9cn
-----END PGP SIGNATURE-----
--=-=-=--

--===============0294844328859297422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============0294844328859297422==--
