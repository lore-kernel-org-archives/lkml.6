Return-Path: <kernel-hardening-return-12317-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu4zwgIEnqhx74xZ1TyKI3NJDury5jYa9gdtQsg9GbLx31st/dHKktD1XQDPIy++1fi/y+R
ARC-Seal: i=1; a=rsa-sha256; t=1520600558; cv=none;
        d=google.com; s=arc-20160816;
        b=Ahi596BFWQG+sqd6h2w/BOykycjZ7GhIcDyMMgqwQTxubvrbUg/c62NIjhuaWL6K3H
         cOT1PM0u+cuAHil+MHeDtibDYyf4rGg94o/xoIp4CzY+p4i+IlWae/VY8JdYE29x4z/u
         aPHmh8H8KD+EM3hwZtBu+MRZrh9BKZlj+eLwqirLZ9J3rXH0xBZXNnUjnnA3dpcDFDhW
         iYffjL4DPewl8nH5rCJ5q52i2qdX1CRLuIjC3eY7xU98+/abZ2pNEuHhVdtlN38UBLZg
         AQfq+VKXbHtgWXusnEPzTlBQzOQc9pvEttr0CupPQST89lpz7bD+7EkWMqVhv2L8kmms
         Pi5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=DjIv4j2F5OEBBmSkcM1mkpSH+SDuvSgKYUnPITgQTRw=;
        b=W7yXJV6zMn7G1XQHr3aiFP/Q+3xS7IsjTswVPBTJ8XFBfFQaQzT6d73D9zurjINn4b
         Vfq6fLaHKfU4qeWLIptMxA3DPVcJo8wwh5BhCmXbxSzMZo2U1YDB3a5Y1yK9I02KoVPm
         rZWk54QH4Ih3GJ3M05F2IB4gCaoaDM2396n/BNKiRjdRbXCi+d+LWsq6d1DOaU90fZh5
         eUx5S4w/X6KuP2sQBRgfL+gA2MFfmW5seMauxK3tSe7CHlGMIJv0w/qPA3Irx2rY2iu+
         JzxyEvx8pGCrTVhwKRo1zLThZmeVhNq951VquZS1z/CNNnCNNI9/9DK+NXptzASkEVA5
         KU7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12317-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12317-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12317-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12317-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 14:02:20 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Mathias Krause <minipli@googlemail.com>
CC: Andreas Christoforou <andreaschristofo@gmail.com>, Kees Cook
	<keescook@chromium.org>, <kernel-hardening@lists.openwall.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI
	<yoshfuji@linux-ipv6.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ipv6: xfrm6_state: remove VLA usage
Message-ID: <20180309130220.is5i4qu3fdcmyngq@gauss3.secunet.de>
References: <1520598106-3271-1-git-send-email-andreaschristofo@gmail.com>
 <CA+rthh9g3gcgTt8jbcRrVUK=Lagnz8HWJJLERwSbMi++3VqS1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+rthh9g3gcgTt8jbcRrVUK=Lagnz8HWJJLERwSbMi++3VqS1A@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: CE3E31A6-8036-4C08-A898-A3929DBA210C
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463771060382720?=
X-GMAIL-MSGID: =?utf-8?q?1594465251685301220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 01:49:07PM +0100, Mathias Krause wrote:
> On 9 March 2018 at 13:21, Andreas Christoforou
> <andreaschristofo@gmail.com> wrote:
> > The kernel would like to have all stack VLA usage removed[1].
> >
> > Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>
> > ---
> >  net/ipv6/xfrm6_state.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv6/xfrm6_state.c b/net/ipv6/xfrm6_state.c
> > index b15075a..45c0d98 100644
> > --- a/net/ipv6/xfrm6_state.c
> > +++ b/net/ipv6/xfrm6_state.c
> > @@ -62,7 +62,12 @@ __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
> >  {
> >         int i;
> >         int class[XFRM_MAX_DEPTH];
> > -       int count[maxclass];
> > +       int *count;
> > +
> > +       count = kcalloc(maxclass + 1, sizeof(*count), GFP_KERNEL);
> > +
> > +       if (!count)
> > +               return -ENOMEM;
> >
> >         memset(count, 0, sizeof(count));
> >
> > @@ -80,6 +85,7 @@ __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
> >                 src[i] = NULL;
> >         }
> >
> > +       kfree(count);
> >         return 0;
> >  }
> 
> Instead of dynamically allocating and freeing memory here, shouldn't
> we just get rid of the maxclass parameter and use XFRM_MAX_DEPTH as
> size for the count[] array, too?

Right, that's the way to go. Aside from that, allocating
with GFP_KERNEL is definitely wrong here.
