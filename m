Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AB8JxZrtJ0/RwZHtEP9i4ByxPFL3jmEWM9RUsNWTjBLGVQaK5mxB+tpCsvbqxn4n7m7Vc3jfbRiI
ARC-Seal: i=1; a=rsa-sha256; t=1525147466; cv=none;
        d=google.com; s=arc-20160816;
        b=yX1ulyb7WIbi5vu9Uz97icygxlMAm+/ZcEhr90e537qJVKsoLV8Gf2Q7K2WGKr21U0
         jtn9F+wHvYOD+6bWvfeVknGWITWp3/MAtgjovHCDtKa/cIVlzN3MyuuHyGr0rXXJKHGO
         o2pTqdhi4PYLuPviqVXMFah27n/B6dZvAIQ6IOr1ZN2jAIsmSPg5GcaVbrYRVz4j51Xz
         AfBIHsHEdKZo+Kn+ppqJey6qdgg/4hZ5rwl4l8Spz3HqwArgIVxbQvZAQJYEK78p2X+r
         yszd9W1zFW8rFZMjtFJib5nuzpv3SEPoNuyxKPlvUbDbnW1/ToWgnm8UNeDkwc5Tah+7
         ORKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=jPEAhOK6PmQiOosjP4HVIPz7meoDUO5vDcrXMcBMBEU=;
        b=mIOb8kwb8Lf5IRLxFcdi6bZCF8zZoIHxJglp7uCfXhqBg9WsqRYua05hQ7pdAwZ2CH
         yhDmq4fKDcC3ftDVsXPSxcah9EJOpHEYnKp5YosMHChi1lUFmMrAWm+ixCJwlQbg7WOy
         3kSR7TYHoELKQb9tjoIWpB7sUeCpmZTGqpkYMM2vCIO7VBqkhjqjO4q5tHlIDPBUFl0P
         OGsgGjJIScm9EZdB85FpRTK9uTPyLO1f57uL1O9uvcQDAkxsAgK8nVh12tU+EGHKcpf/
         1OM7DypAlFTLFZxCZOgik2G7UqKTHOiWX91K1PyD9Rtvta5CCQ7/B99ERmXxgmlDYATJ
         vkhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,349,1520924400";
   d="scan'208";a="37444423"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 01/10] staging: lustre: ldlm: store name directly in
 namespace.
Thread-Topic: [PATCH 01/10] staging: lustre: ldlm: store name directly in
 namespace.
Thread-Index: AQHT4P/q6yCnmFZRCE+A4LP23VuYHaQatlKA
Date: Tue, 1 May 2018 04:04:24 +0000
Message-ID: <74BA6824-9336-47B6-BCD6-A2E91E15A115@intel.com>
References: <152514658325.17843.11455067361317157487.stgit@noble>
 <152514675876.17843.12443354625160742215.stgit@noble>
In-Reply-To: <152514675876.17843.12443354625160742215.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.137.157]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13AFF2C206627242836D3A021143B5DD@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232316691358736?=
X-GMAIL-MSGID: =?utf-8?q?1599233029664692661?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Apr 30, 2018, at 21:52, NeilBrown <neilb@suse.com> wrote:
>=20
> Rather than storing the name of a namespace in the
> hash table, store it directly in the namespace.
> This will allow the hashtable to be changed to use
> rhashtable.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lustre/include/lustre_dlm.h |    5 ++++-
> drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |    5 +++++
> 2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/include/lustre_dlm.h b/drivers=
/staging/lustre/lustre/include/lustre_dlm.h
> index d668d86423a4..b3532adac31c 100644
> --- a/drivers/staging/lustre/lustre/include/lustre_dlm.h
> +++ b/drivers/staging/lustre/lustre/include/lustre_dlm.h
> @@ -362,6 +362,9 @@ struct ldlm_namespace {
> 	/** Flag indicating if namespace is on client instead of server */
> 	enum ldlm_side		ns_client;
>=20
> +	/** name of this namespace */
> +	char			*ns_name;
> +
> 	/** Resource hash table for namespace. */
> 	struct cfs_hash		*ns_rs_hash;
>=20
> @@ -878,7 +881,7 @@ static inline bool ldlm_has_layout(struct ldlm_lock *=
lock)
> static inline char *
> ldlm_ns_name(struct ldlm_namespace *ns)
> {
> -	return ns->ns_rs_hash->hs_name;
> +	return ns->ns_name;
> }
>=20
> static inline struct ldlm_namespace *
> diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c b/drivers=
/staging/lustre/lustre/ldlm/ldlm_resource.c
> index 6c615b6e9bdc..43bbc5fd94cc 100644
> --- a/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
> +++ b/drivers/staging/lustre/lustre/ldlm/ldlm_resource.c
> @@ -688,6 +688,9 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_=
device *obd, char *name,
> 	ns->ns_obd      =3D obd;
> 	ns->ns_appetite =3D apt;
> 	ns->ns_client   =3D client;
> +	ns->ns_name     =3D kstrdup(name, GFP_KERNEL);
> +	if (!ns->ns_name)
> +		goto out_hash;
>=20
> 	INIT_LIST_HEAD(&ns->ns_list_chain);
> 	INIT_LIST_HEAD(&ns->ns_unused_list);
> @@ -730,6 +733,7 @@ struct ldlm_namespace *ldlm_namespace_new(struct obd_=
device *obd, char *name,
> 	ldlm_namespace_sysfs_unregister(ns);
> 	ldlm_namespace_cleanup(ns, 0);
> out_hash:
> +	kfree(ns->ns_name);
> 	cfs_hash_putref(ns->ns_rs_hash);
> out_ns:
> 	kfree(ns);
> @@ -993,6 +997,7 @@ void ldlm_namespace_free_post(struct ldlm_namespace *=
ns)
> 	ldlm_namespace_debugfs_unregister(ns);
> 	ldlm_namespace_sysfs_unregister(ns);
> 	cfs_hash_putref(ns->ns_rs_hash);
> +	kfree(ns->ns_name);
> 	/* Namespace \a ns should be not on list at this time, otherwise
> 	 * this will cause issues related to using freed \a ns in poold
> 	 * thread.
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
