Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELvArlsFmoRwH+9dcJuoy9xQDuVn6dIXGD/vk2OZgya6+0P5lxYKVetP00JAljjQSJ//PosS
ARC-Seal: i=1; a=rsa-sha256; t=1520456927; cv=none;
        d=google.com; s=arc-20160816;
        b=qFedXI0gsaVEbGJxitio2/jU7txHrPJVttJWWi5HH8251ljfILPQd3W2epmnlT/AKj
         HRvn3MqLAQAnh+l2eQcAHwHDpyf+FMfJmKVwJpXh6pjRIED9qVVQXeGqrBnjUM+DH/p2
         CY2gHK0Hv0rlzsWfb+U3H2RyibGbxfIaXiDaahx5Az5hwifQt9XCrQumeiKiwzqKlO29
         w6oXeM2rzTdpg0+Llnof4HleIPnX9X4hEeZgcUT7Ig+N6ju6NawNNC4EgoNOfY2ICzyR
         szWy/MOqleBLlHVVYjfud1hCPSQUZsWQjnnSdvxHWoYGEde0e1QucItmEJNZpCG4FVmQ
         AzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=CmNXXGvaRXqsC/0zN5sga03wGl2F9QsEtTq4JHTLfUU=;
        b=PnM1qoNDfhM/Fg//khcvJ9yXlKAWuZ9i7jesiPSYoueWU4ZwPcNpMZEnaJGTQd3hM4
         7Up4i8P6PMEEw+MVywsaPWwnI/hl/BbACgSJ4dKvhHHACNgo+Ebjfo1VE1NkEFBvEJlk
         6OAmAsDpMLU+DasCCtaFAEpraNDwuoDBihes1fUupBA4ILmjXELyuOGzu9PMpvNqzh5D
         RVYejbInlMiFBtftOB5tWnvsHqYqabvq4PVIfYmhQqQiXLB5Zfxjy8JuKQysX120fxFi
         oObbCXtkhpeizPsmiYl9ZOd28fhG0vUfJOqDq+6itX/6jdNC9nyG0Zt4c2l2zpXbJEdm
         zQ/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="23340535"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 03/17] staging: lustre: statahead: remove incorrect test
 on agl_list_empty()
Thread-Topic: [PATCH 03/17] staging: lustre: statahead: remove incorrect
 test on agl_list_empty()
Thread-Index: AQHTsbWbwtPAEwUOXUWCffhH7g5yzKPF06WA
Date: Wed, 7 Mar 2018 21:08:45 +0000
Message-ID: <4D8083A9-175E-418C-ACD3-252A34EF4746@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708514.7628.7094184804431206060.stgit@noble>
In-Reply-To: <151994708514.7628.7094184804431206060.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.6.233]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9909C947FC67144EBAEC2740DB62A457@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780107647480528?=
X-GMAIL-MSGID: =?utf-8?q?1594314642984457219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> Including agl_list_empty() in the wait_event_idle() condition
> is pointless as the body of the loop doesn't do anything
> about the agl list.
> So if the list wasn't empty, the while loop would spin
> indefinitely.
>=20
> The test was removed in the lustre-release commit
> 672ab0e00d61 ("LU-3270 statahead: small fixes and cleanup"),
> but not in the Linux commit 5231f7651c55 ("staging: lustre:
> statahead: small fixes and cleanup").
>=20
> Fixes: 5231f7651c55 ("staging: lustre: statahead: small fixes and cleanup=
")
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lustre/llite/statahead.c |    1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/llite/statahead.c b/drivers/st=
aging/lustre/lustre/llite/statahead.c
> index 6052bfd7ff05..ba00881a5745 100644
> --- a/drivers/staging/lustre/lustre/llite/statahead.c
> +++ b/drivers/staging/lustre/lustre/llite/statahead.c
> @@ -1124,7 +1124,6 @@ static int ll_statahead_thread(void *arg)
> 	while (thread_is_running(sa_thread)) {
> 		wait_event_idle(sa_thread->t_ctl_waitq,
> 				sa_has_callback(sai) ||
> -				!agl_list_empty(sai) ||
> 				!thread_is_running(sa_thread));
>=20
> 		sa_handle_callback(sai);
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
