Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755114AbeDTNio (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:38:44 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:55680 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754934AbeDTNim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:38:42 -0400
Subject: Re: [PATCH v2 01/10] media: v4l2-ctrls: Add missing v4l2 ctrl unlock
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
 <20180419154124.17512-2-paul.kocialkowski@bootlin.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <47861cbd-e385-66c0-798d-f6ff3f454bac@xs4all.nl>
Date: Fri, 20 Apr 2018 15:38:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180419154124.17512-2-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAh2FHCUgoRH2I9lRUIPo9prfxSDF8srF4VqsJzeK1/By9zeG/VUe1iP1BQ5DeIpBdFygjTiJitCZZgd7AVuGXATJ/Qg3GazWwKU7NhGmJ0NUnG+Ppuv
 ij4y85lGQC+YjnmAfINfZbIm1W8/fWpA1UAtfJV+EQLengcdx4wv4vdpxkOWY3oltLMwV9kCsqfValWHjE0qe+vFq+ZJNWne/ymSXNIc5uvUy6comW7ghbaB
 T7UVr6VViAOkX5Sl9FE7yuDHkY5I3ZHsVMBzaqWPm08diCLcgOqkaUHgOOKkY1zQeZUKrArWZcDJEcEDU/KL9pjrTq9dLSi9IeF+fYGouYjXJmt5bgbV1gGi
 yU5uwIvOu0KZxihmkgiH4N4kVZOkSBklpL9qGXUDeyht81ytZfAC9YNjCMkSuNCngM8RmKW9mwbQu36HSfYO64GYe1sPycuDm59xPREU3wcRNwebsH/xfhU1
 CM7+xNLC1oo2IODobBNpJOTbrrmWtZ8rBZT98JzaLj8gyPAFikHuLmk5+os3ir6fj1uJyLG2zq0j/3X/LwMcBr7XFWhaeHSI+VD97K1TbIrcLryLPLVuSaot
 65qkTnBVojMdGUys/3AHIrUqx+m2zxyIJvDELwuSSBNI+DdIawYFgd8gP542wogH2zpCzMP6XUXtKUyTbMv/czwuH6HdgCV1ijLaYNok4K7uBGeUexxXPuis
 +dhiBX0e00D2rvESd+9/m3xF5i0HQ4z4nL9Xb0JdpLEXNF7MMBhmNgDxpUZQvOtwfxQe8+BeJWUDF8VAh12FJFXM6SuGomtOg+3NseT4ZpDOIBEisp1gYqaP
 9HtUCtAz/rCvuDjblzqzn7TcRIE+8QoqwoXyPfRQRlscMemAw1dWcKGyBzPTNpBUwc9wBUClDD7LjqplJI0d21CA2S1LJuJvh3iXeBSxPhLxR+cBwZjEOd4L
 GL0F+Gbex+iQVDnE2egjiUgpyD58NHzdzGZGMfvShwwwxA4nHUszJM9oIczC/oROmOUO6myvBmCK3UWNlpyBzUZ2YG6dyYKwJoQ5Na6deWl2pm8MK8BZpFv4
 tReoC/R6muGXuogmQmW9xBTR36bcWIB4fypePcASxxF4CA4XE2DDuU23
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/18 17:41, Paul Kocialkowski wrote:
> This adds a missing v4l2_ctrl_unlock call that is required to avoid
> deadlocks.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/media/v4l2-core/v4l2-ctrls.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index f67e9f5531fa..ba05a8b9a095 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -3614,10 +3614,12 @@ void v4l2_ctrl_request_complete(struct media_request *req,
>  			continue;
>  
>  		v4l2_ctrl_lock(ctrl);
> +
>  		if (ref->req)
>  			ptr_to_ptr(ctrl, ref->req->p_req, ref->p_req);
>  		else
>  			ptr_to_ptr(ctrl, ctrl->p_cur, ref->p_req);
> +
>  		v4l2_ctrl_unlock(ctrl);
>  	}
>  
> @@ -3677,8 +3679,11 @@ void v4l2_ctrl_request_setup(struct media_request *req,
>  				}
>  			}
>  		}
> -		if (!have_new_data)
> +
> +		if (!have_new_data) {
> +			v4l2_ctrl_unlock(master);
>  			continue;
> +		}

Oops! Thanks for finding this. I'll fold this into the relevant patch in my tree.

>  
>  		for (i = 0; i < master->ncontrols; i++) {
>  			if (master->cluster[i]) {
> 

Regards,

	Hans
