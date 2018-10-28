Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D015BC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7833420843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZjpBdoKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7833420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeJ2BUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:20:55 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:47511 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeJ2BUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:20:55 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w9SGZUMd010426;
        Mon, 29 Oct 2018 01:35:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9SGZUMd010426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540744531;
        bh=IO26zXAOHtciBK5nNiZyqy1jcUD+neI1T8fhI+956dQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZjpBdoKRuTsKm3eVwXHtZ2jPyhEi6yT+b/CbKBFcg5EoRJ9R1sBaZ2vJjl7aQKMgR
         aIA5G+ny7gG4I6zCZmK8juM3kU8eAuMnG6nN6dLG/2x5MdP6kPYD0+UXNTAb7ibPlp
         TpjnHNoPuje2JCImW1X++rHB1KSjxCV8/6YHXLxCu1ox5F7K/Zhc+x9nGdZ3AF/BxV
         1gKL94fbQxEdE8+lXLdwpEwcfhmFR/GgOSJOYH1iVF/8F0m9XsEdxn4J97E4zDMZM7
         v93gNSg7e9fv2CqA5nxglg+dGB+pjB0HdaUOxZOccQ1XLrYhQhiLw3L9Jn08vHTZM9
         RUEjBiDfZJgxQ==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id o17so2114838uad.8;
        Sun, 28 Oct 2018 09:35:30 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKR3NFqPOeK88WAOm92kawCrKw4IBORUu83NF4Umgznx763nekm
        CLv98hWvxc0hpo39XiplJLMfeYCYqz6p1gPwjEM=
X-Google-Smtp-Source: AJdET5cdlJJ44Fw8xQAumEWOxlAFq8yOgK38Xpfid5e04aZMVxVLSt6ecrWfr+V1s89QRXwvAIOkEYsuJFIHVQ+QQu4=
X-Received: by 2002:a9f:28c4:: with SMTP id d62mr4591498uad.42.1540744529754;
 Sun, 28 Oct 2018 09:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181024040354.24879-1-leobras.c@gmail.com> <20181024040354.24879-2-leobras.c@gmail.com>
In-Reply-To: <20181024040354.24879-2-leobras.c@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Oct 2018 01:34:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR1OQsou-i85JLuWG2GdGx17fqhh9GN36QgahMm9N+DTw@mail.gmail.com>
Message-ID: <CAK7LNAR1OQsou-i85JLuWG2GdGx17fqhh9GN36QgahMm9N+DTw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] x86/vdso: Renames variable to fix shadow warning.
To:     =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     lkcamp@lists.libreplanetbr.org, Borislav Petkov <bp@alien8.de>,
        David.Laight@aculab.com, Andy Lutomirski <luto@kernel.org>,
        helen@koikeco.de, Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,


On Wed, Oct 24, 2018 at 1:04 PM Leonardo Bras <leobras.c@gmail.com> wrote:
>
> The go32() and go64() functions have an argument and a local variable
> called =E2=80=98name=E2=80=99.  Rename both to clarify the code and to fi=
x a warning
> with -Wshadow.
>
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>


Please take care of this in x86 tree instead of kbuild.


Thanks.


> ---
>  arch/x86/entry/vdso/vdso2c.h | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
> index fa847a620f40..a20b134de2a8 100644
> --- a/arch/x86/entry/vdso/vdso2c.h
> +++ b/arch/x86/entry/vdso/vdso2c.h
> @@ -7,7 +7,7 @@
>
>  static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
>                          void *stripped_addr, size_t stripped_len,
> -                        FILE *outfile, const char *name)
> +                        FILE *outfile, const char *image_name)
>  {
>         int found_load =3D 0;
>         unsigned long load_size =3D -1;  /* Work around bogus warning */
> @@ -93,11 +93,12 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_l=
en,
>                 int k;
>                 ELF(Sym) *sym =3D raw_addr + GET_LE(&symtab_hdr->sh_offse=
t) +
>                         GET_LE(&symtab_hdr->sh_entsize) * i;
> -               const char *name =3D raw_addr + GET_LE(&strtab_hdr->sh_of=
fset) +
> -                       GET_LE(&sym->st_name);
> +               const char *sym_name =3D raw_addr +
> +                                      GET_LE(&strtab_hdr->sh_offset) +
> +                                      GET_LE(&sym->st_name);
>
>                 for (k =3D 0; k < NSYMS; k++) {
> -                       if (!strcmp(name, required_syms[k].name)) {
> +                       if (!strcmp(sym_name, required_syms[k].name)) {
>                                 if (syms[k]) {
>                                         fail("duplicate symbol %s\n",
>                                              required_syms[k].name);
> @@ -134,7 +135,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_l=
en,
>         if (syms[sym_vvar_start] % 4096)
>                 fail("vvar_begin must be a multiple of 4096\n");
>
> -       if (!name) {
> +       if (!image_name) {
>                 fwrite(stripped_addr, stripped_len, 1, outfile);
>                 return;
>         }
> @@ -157,7 +158,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_l=
en,
>         }
>         fprintf(outfile, "\n};\n\n");
>
> -       fprintf(outfile, "const struct vdso_image %s =3D {\n", name);
> +       fprintf(outfile, "const struct vdso_image %s =3D {\n", image_name=
);
>         fprintf(outfile, "\t.data =3D raw_data,\n");
>         fprintf(outfile, "\t.size =3D %lu,\n", mapping_size);
>         if (alt_sec) {
> --
> 2.19.1
>


--=20
Best Regards
Masahiro Yamada
