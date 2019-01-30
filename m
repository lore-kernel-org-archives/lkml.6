Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB427C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A4E218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="o1PkRHWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbfA3VWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:22:03 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:42052 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbfA3VWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:22:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 4C39014E8;
        Wed, 30 Jan 2019 22:22:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1548883316; x=1550697717; bh=lAQ7XiRnepRld5r6IoRBXNJeSetHsmue+Dq
        qdwnur4o=; b=o1PkRHWbleuL1Grx1ibS+cQx8qQptihDyjV9+hF87rKZjofnwQe
        xhYKnVratJBMaMYP9CzvHhIxBQXazI6CvdzMdsCQDOhK2ZGQdN96A9OWrvpBd3Pi
        MStdDqbFeGZeIhFFK/6SoN7Lp5i12IJZzlHtF6Fh8zKpsVlcE5VYlkkhSgrnjKwO
        teig3ASgk2XJc9Xd1gTtvFfZrVr3rVWHhdPMEVMx0ylT3CD7lAu+J33BtcQU59aO
        i4l6FvNhNzABS2/p38lMT2DMzkV46Zkdyw6J7nez6Wzbacx4r6fKNz7fUd/CUshD
        EnUQOHbplsUx1Ltm9Reu/tOSs6KCYTosr11sJgpNQ7p3V9sE3gSxFw+/XMut+Dup
        8R1EWqHPCL516GOht+6rcj+YAu4pWGWvLlG5uKPHHcSXG0xx9cOqChCWjf5DS9iq
        9MQzjOtMA+Y4iTcMq8E/sMLHCKQ99ZupPHvgdro1L6pbHus16zugF+nzCXjwWsrg
        0kavye6QnvUsQLtYeYPSFhKDZ9Z9Psdp9dXnM031MNfUphROQWAXGYgNym+V7YNu
        4muthxm8oDmQwMBeMOqE6PlOZRjV2ZLPbU3Dum2o8HokZyZu0YT0+Gorp5w9lnzG
        wlVvljlS25LoSoND0A7AUwNZylwxKD29SrZPZS+scFqiYNFzUWYUCbK8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u7lrI-T5KhCm; Wed, 30 Jan 2019 22:21:56 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 61E3B112A;
        Wed, 30 Jan 2019 22:21:56 +0100 (CET)
Received: from int-subm003.mykolab.com (unknown [10.9.37.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 6C3C12579;
        Wed, 30 Jan 2019 22:21:53 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 30 Jan 2019 22:21:51 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org,
        Kepplinger Martin <Martin.Kepplinger@ginzinger.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Michael Rodin <michael-git@rodin.online>,
        Minghui Liu <minghui.liu.95@gmail.com>,
        Grigory Shipunov <mail@oxapentane.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Coly Li <colyli@suse.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc: Change LXR references to elixir.bootlin.com
In-Reply-To: <20190130172528.7552-1-j.neuschaefer@gmx.net>
References: <20190130172528.7552-1-j.neuschaefer@gmx.net>
Message-ID: <1b313cc4aa1c39d8de7fc1cb95a3d7da@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-30 18:25, Jonathan Neuschäfer wrote:
> Recently, Free Electrons was renamed to Bootlin[1]. Less recently, the
> Linux Cross Reference (LXR) at lxr.free-electrons.com was replaced by
> Elixir[2], and lxr.free-electrons.com redirected first to
> elixir.free-electrons.com and now to elixir.bootlin.com.
> 
> [1]: https://bootlin.com/blog/free-electrons-becomes-bootlin/
> [2]: https://github.com/free-electrons/elixir
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

> ---
> 
> v2:
> - Fix ident search URL, as suggested by Martin Kepplinger
> - Add trailing slash, which I accidentally dropped in v1 in
>   Documentation/translations/it_IT/process/howto.rst
> 
> v1: 
> https://lore.kernel.org/lkml/20190129142923.5743-1-j.neuschaefer@gmx.net/
> ---
>  Documentation/input/devices/xpad.rst               | 2 +-
>  Documentation/process/howto.rst                    | 2 +-
>  Documentation/process/kernel-docs.rst              | 2 +-
>  Documentation/translations/it_IT/process/howto.rst | 2 +-
>  Documentation/translations/ja_JP/howto.rst         | 2 +-
>  Documentation/translations/ko_KR/howto.rst         | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/input/devices/xpad.rst
> b/Documentation/input/devices/xpad.rst
> index b8bd65962dd8..173c2acda9fd 100644
> --- a/Documentation/input/devices/xpad.rst
> +++ b/Documentation/input/devices/xpad.rst
> @@ -218,7 +218,7 @@ References
>  .. [1] http://euc.jp/periphs/xbox-controller.ja.html (ITO Takayuki)
>  .. [2] http://xpad.xbox-scene.com/
>  .. [3] http://www.markosweb.com/www/xboxhackz.com/
> -.. [4] http://lxr.free-electrons.com/ident?i=xpad_device
> +.. [4] https://elixir.bootlin.com/linux/latest/ident/xpad_device
> 
> 
>  Historic Edits
> diff --git a/Documentation/process/howto.rst 
> b/Documentation/process/howto.rst
> index 00c8ddd2ed2c..64deab5cfb3b 100644
> --- a/Documentation/process/howto.rst
> +++ b/Documentation/process/howto.rst
> @@ -225,7 +225,7 @@ Cross-Reference project, which is able to present
> source code in a
>  self-referential, indexed webpage format. An excellent up-to-date
>  repository of the kernel code may be found at:
> 
> -	http://lxr.free-electrons.com/
> +	https://elixir.bootlin.com/
> 
> 
>  The development process
> diff --git a/Documentation/process/kernel-docs.rst
> b/Documentation/process/kernel-docs.rst
> index 3fb28de556e4..ab12dddc773e 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -565,7 +565,7 @@ Miscellaneous
> 
>      * Name: **Cross-Referencing Linux**
> 
> -      :URL: http://lxr.free-electrons.com/
> +      :URL: https://elixir.bootlin.com/
>        :Keywords: Browsing source code.
>        :Description: Another web-based Linux kernel source code 
> browser.
>          Lots of cross references to variables and functions. You can 
> see
> diff --git a/Documentation/translations/it_IT/process/howto.rst
> b/Documentation/translations/it_IT/process/howto.rst
> index 909e6a55bc43..f9a44b1af89d 100644
> --- a/Documentation/translations/it_IT/process/howto.rst
> +++ b/Documentation/translations/it_IT/process/howto.rst
> @@ -234,7 +234,7 @@ il progetto Linux Cross-Reference, che è in grado
> di presentare codice
>  sorgente in un formato autoreferenziale ed indicizzato. Un eccellente 
> ed
>  aggiornata fonte di consultazione del codice del kernel la potete 
> trovare qui:
> 
> -	http://lxr.free-electrons.com/
> +	https://elixir.bootlin.com/
> 
> 
>  Il processo di sviluppo
> diff --git a/Documentation/translations/ja_JP/howto.rst
> b/Documentation/translations/ja_JP/howto.rst
> index f3116381c26b..2ca9389d5915 100644
> --- a/Documentation/translations/ja_JP/howto.rst
> +++ b/Documentation/translations/ja_JP/howto.rst
> @@ -245,7 +245,7 @@ Linux カーネルソースツリーの中に含まれる、きれいにし、
>  できます。この最新の素晴しいカーネルコードのリポジトリは以下で見つかり
>  ます -
> 
> -	http://lxr.free-electrons.com/
> +	https://elixir.bootlin.com/
> 
>  開発プロセス
>  ------------
> diff --git a/Documentation/translations/ko_KR/howto.rst
> b/Documentation/translations/ko_KR/howto.rst
> index a8197e072599..9fc869087e9c 100644
> --- a/Documentation/translations/ko_KR/howto.rst
> +++ b/Documentation/translations/ko_KR/howto.rst
> @@ -235,7 +235,7 @@ ReST 마크업을 사용하는 문서들은 Documentation/output 에 생성된
>  소스코드를 인덱스된 웹 페이지들의 형태로 보여준다. 최신의 멋진 커널
>  코드 저장소는 다음을 통하여 참조할 수 있다.
> 
> -      http://lxr.free-electrons.com/
> +      https://elixir.bootlin.com/
> 
> 
>  개발 프로세스

-- 
Federico Vaga
http://www.federicovaga.it/
