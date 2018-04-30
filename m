Return-Path: <boris.ostrovsky@oracle.com>
X-Google-Smtp-Source: AB8JxZpO24KOw2+91a+4Jd+IHUCRL95VvOmdzuTdZaV+3hDHFM66TeczhP8jFHmxsrqzKaySgVA9
ARC-Seal: i=1; a=rsa-sha256; t=1525123390; cv=none;
        d=google.com; s=arc-20160816;
        b=jyEN+BXyg+pSZO8D5UfcNFrv3TqM3xoXQ1MubF+NyoGwulWI+xndZXYwhchhVtk7EK
         4/N4jZKAaFI52uS+AOD+ulTJcATLqV6IqdlNo0OogMZ8Y/HJd1gq1T5I3Z94vqoTnLny
         APpJA4ZmOJ2jNmbEd7cqBEv6sxG+DfVJABEuOm8CZ/qwtZ5wI4C/j0fllPh4kDj9pBAR
         llbs71t9Hme3YGp64SsvYBwEooY2zbeW8Dkx+2kJhkKMI/jOZPvOoKBlo4dQpjjAUISU
         AUBDr+7+Od6cEDalsaYZ+XvdbZGeYZA25myLTc1YuX6CLdC1T5Md2aUsA8mD1HNG/yek
         LLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:autocrypt:openpgp:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=G10qias8GpRQZr8VIJivobOvOUyarGYOPRCFFN2hrIE=;
        b=v+z52D/RLPTN71kFwfLeddbf0dhOzkvNRSPOHiKH5VKSiN+uRs5k+0EQoxwWUbYcm9
         IfUlMOUm6/Ip8L6LC6mu2nwQl+uD0Yd8eeiepcxY9sGNHn1bBsZnrrxrmA3bszwItAJy
         fAluS2spib2LyiXHkfTubj7n8gD55FBpLN/Thg5YFXpD5Se9bOLd6/mfQkQa/Bv1g7c0
         4p9he4FBX0hRKg4i1p7XPg4Q06dXDPvebVI97DBwiSZNKcZLglfJaoL1D6K8v0QNGyFy
         qgvpR+KK07KBtq9RK4Hh9nbzgY2UFcY8AfvlJBAFqpvREBoFdK4mCO0pHzXUAtHOkMAy
         r2Bg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=XCeSSh7c;
       spf=pass (google.com: domain of boris.ostrovsky@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=boris.ostrovsky@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=XCeSSh7c;
       spf=pass (google.com: domain of boris.ostrovsky@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=boris.ostrovsky@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH 1/6] xen: Add RING_COPY_RESPONSE()
To: =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
 <marmarek@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org
Cc: stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
 <ba8ed01b01a81d79f6d1c59e08a318dc0309a95d.1525122026.git-series.marmarek@invisiblethingslab.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <7bd2ff07-9d29-8dea-6f55-5ff24ddd433c@oracle.com>
Date: Mon, 30 Apr 2018 17:25:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ba8ed01b01a81d79f6d1c59e08a318dc0309a95d.1525122026.git-series.marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300205
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599206514582393812?=
X-GMAIL-MSGID: =?utf-8?q?1599207784046459351?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 05:01 PM, Marek Marczykowski-Górecki wrote:
> Using RING_GET_RESPONSE() on a shared ring is easy to use incorrectly
> (i.e., by not considering that the other end may alter the data in the
> shared ring while it is being inspected).  Safe usage of a response
> generally requires taking a local copy.
>
> Provide a RING_COPY_RESPONSE() macro to use instead of
> RING_GET_RESPONSE() and an open-coded memcpy().  This takes care of
> ensuring that the copy is done correctly regardless of any possible
> compiler optimizations.
>
> Use a volatile source to prevent the compiler from reordering or
> omitting the copy.
>
> This is complementary to XSA155.
>
> CC: stable@vger.kernel.org
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> ---
>  include/xen/interface/io/ring.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
> index 3f40501..03702f6 100644
> --- a/include/xen/interface/io/ring.h
> +++ b/include/xen/interface/io/ring.h
> @@ -201,6 +201,20 @@ struct __name##_back_ring {						\
>  #define RING_GET_RESPONSE(_r, _idx)					\
>      (&((_r)->sring->ring[((_idx) & (RING_SIZE(_r) - 1))].rsp))
>  
> +/*
> + * Get a local copy of a response.
> + *
> + * Use this in preference to RING_GET_RESPONSE() so all processing is
> + * done on a local copy that cannot be modified by the other end.
> + *
> + * Note that https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 may cause this
> + * to be ineffective where _rsp is a struct which consists of only bitfields.
> + */
> +#define RING_COPY_RESPONSE(_r, _idx, _rsp) do {				\
> +	/* Use volatile to force the copy into _rsp. */			\
> +	*(_rsp) = *(volatile typeof(_rsp))RING_GET_RESPONSE(_r, _idx);	\
> +} while (0)
> +

To avoid repeating essentially the same comment, can you move
RING_COPY_RESPONSE definition next to RING_COPY_REQUEST and adjust the
existing comment? And probably move RING_GET_RESPONSE next to
RING_GET_REQUEST? In other words

#define RING_GET_REQUEST
#define RING_GET_RESPONSE

/* comment */
#define RING_COPY_REQUEST
#define RING_COPY_RESPONSE


Also, perhaps the two can be collapsed together, along the lines of

#define RING_COPY_(action, _r, _idx, _msg) do {                          \
        /* Use volatile to force the copy into _msg. */                 \
        *(_msg) = *(volatile typeof(_msg))RING_GET_##action(_r, _idx);   \
} while (0)

#define RING_COPY_REQUEST(_r, _idx, _req)  RING_COPY_(REQUEST, _r, _idx,
_req)
#define RING_COPY_RESPONSE(_r, _idx, _rsp)  RING_COPY_(RESPONSE, _r,
_idx, _rsp)


(I have not tried to compile this so it may well be wrong)

-boris



>  /* Loop termination condition: Would the specified index overflow the ring? */
>  #define RING_REQUEST_CONS_OVERFLOW(_r, _cons)				\
>      (((_cons) - (_r)->rsp_prod_pvt) >= RING_SIZE(_r))
