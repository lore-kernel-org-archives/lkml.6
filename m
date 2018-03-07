Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELsF8Vh0g43x+v1/Ov7g7Df0/HjnihH8hS5609xxlSJL+xCYBXh7wVnA4GG3ETCLSy3azMkO
ARC-Seal: i=1; a=rsa-sha256; t=1520457887; cv=none;
        d=google.com; s=arc-20160816;
        b=cG40KUexSNviNXrG44wKwI00GTb033uVBAXN+nFUPX8Uyj8r9f7KfON0r4Nbo9UgcI
         yeimmPmDLpFb9SUcteq0buppVm9K5F80G+tPwR70F/tvfuB8tSZNQ7C6N1mr45qstthm
         20lZH6knJg4CA0bUQbQ1NdPtuznIz0cNxQxldgy19yED4QmckXRAH4EPFAMQsvCtSnAI
         03m0orM4Zw6VVebmS6FCLLNAjJEubbDbQFuQlJa70tC3pCLI8/EhysaZf4Y9zCtRqbU5
         vqSH3Ei0d/9VDbzio7v8H5CSVadz5uwMCpwkUOvOkrR9rWOlMX8mlTGKkEKQtmNbzDBz
         EKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=hYV7p6EAH/XrsPhdkRfk5aynOfJZHpPI6rkUzz+h+tY=;
        b=k0Bb0ylp088/0y9pG53LhBGxxBTM+lqroNhkBxxHVnmypqHqotBDWAAmvOKPOxAoUX
         d5V8DFHI9mc8ZvgS8JWRHvFVvfNNl342pa9sFy3xLY5sO0tHmMBMHsI5Xhv9WLu9Shep
         nrLyOQEZ4cFhcLW49irIiAVjstakPKOJcmxKxZGdiG52ZkqD8kuqU6gamRcpyE/Vk9fv
         y3efeVUmH2lnGPTgUGLHPYtFNNgo1QceX/eQ0lysIOsHIn2EMLy0xu4Y6WBIRVti5ScQ
         FbtxfPTPEaNXijN/fajqPpVqRjWDVAJ7frHAf/EIYDJvMY84TlfxDtu6TgVhD6mpjW43
         XWhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="22836604"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 05/17] staging: lustre: lnet: keep ln_nportals consistent
Thread-Topic: [PATCH 05/17] staging: lustre: lnet: keep ln_nportals
 consistent
Thread-Index: AQHTsbWhUnueJw3apEa+L8kuiQjaj6PF2BwA
Date: Wed, 7 Mar 2018 21:24:45 +0000
Message-ID: <7BA17B93-50EA-41F3-890D-69EA4FE468F5@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708521.7628.13905456558048566520.stgit@noble>
In-Reply-To: <151994708521.7628.13905456558048566520.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.6.233]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC162B80A0B48340BFB55EF0C596C3B0@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780122780902634?=
X-GMAIL-MSGID: =?utf-8?q?1594315649775430527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> ln_nportals should be zero when no portals have
> been allocated.  This ensures that memory allocation failure
> is handled correctly elsewhere.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lnet/lnet/lib-ptl.c |    5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lnet/lnet/lib-ptl.c b/drivers/staging=
/lustre/lnet/lnet/lib-ptl.c
> index 471f2f6c86f4..fc47379c5938 100644
> --- a/drivers/staging/lustre/lnet/lnet/lib-ptl.c
> +++ b/drivers/staging/lustre/lnet/lnet/lib-ptl.c
> @@ -841,6 +841,7 @@ lnet_portals_destroy(void)
>=20
> 	cfs_array_free(the_lnet.ln_portals);
> 	the_lnet.ln_portals =3D NULL;
> +	the_lnet.ln_nportals =3D 0;
> }
>=20
> int
> @@ -851,12 +852,12 @@ lnet_portals_create(void)
>=20
> 	size =3D offsetof(struct lnet_portal, ptl_mt_maps[LNET_CPT_NUMBER]);
>=20
> -	the_lnet.ln_nportals =3D MAX_PORTALS;
> -	the_lnet.ln_portals =3D cfs_array_alloc(the_lnet.ln_nportals, size);
> +	the_lnet.ln_portals =3D cfs_array_alloc(MAX_PORTALS, size);
> 	if (!the_lnet.ln_portals) {
> 		CERROR("Failed to allocate portals table\n");
> 		return -ENOMEM;
> 	}
> +	the_lnet.ln_nportals =3D MAX_PORTALS;
>=20
> 	for (i =3D 0; i < the_lnet.ln_nportals; i++) {
> 		if (lnet_ptl_setup(the_lnet.ln_portals[i], i)) {
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
