Return-Path: <kernel-hardening-return-11627-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227V5k+nag4M4vTkTFWVyMmQ0y4lWh6FGwwRNucHZbFfdBVarS31hRNTttEFGrq7LWwyjn44
ARC-Seal: i=1; a=rsa-sha256; t=1517879270; cv=none;
        d=google.com; s=arc-20160816;
        b=rLBZc8IfoxOmLcTKWp90it29UCkVb8RxvM/pBHF738zhL4uwPEu62s0PQODUjV7Gdy
         gnRQsPrrQe026JcC6w88yZmghDiErbqHDQbuKsaKb8w/zmC+TqAUfI5mH3Zc8dO2Eslc
         nZmawNmEgfE5s6nDJOCzs+T9S8UD7gZZDGwfuH13PUrRPrtEgATb0f8AjW4vPjUPh8yW
         F0QeJMFsHJ2w3J2Q1/rpfOLIA4jpQSmPttmRk3PvNI0qM80Z1M6WUz+lz6xPP5Lj4UYt
         /0XNznWHbP3zFPSHLUUMcjuFG+dvphq0CIa9/Ioyn9zNd4Gpy+eTFSSFhit3iKh9syTf
         d8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=NtXtDVxfsNX8AVrBws/1xBpUVYPXf6QVwKBrQ7hCIec=;
        b=XJAZ07TSwj+hzhvH6rKOCu6o3/BNsHVJRiOAyjF65Xxt9dhiF5NvM+ZhHhAVSkLh10
         1BQWllMgjJ3DpiYyn9Z7fvEPpwgTPQdEbC4FhBz39Q8Yaud5e7OS5yFaDZNULM3yhfqk
         +K1DLH3JvDiZtWtRCLsd8rcOC0DhWsJR6Z3juySH1zDorlefFXKAcLuun2sl7zkNShBf
         f3ynLZXOjRWTdMsV7xASifBloNgmT63cj6k0oZrMUA5aCNs9l0Faq1FXwpLX0QAXdAZI
         /fXQtTw65Y6ZtWSRUQt7JLK2B+5ahDpO/K7DOad9uL3hJmeJLsVIqQjeldT/y5q0rDLr
         JdbA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Jmo6kIv4;
       dkim=pass header.i=@chromium.org header.s=google header.b=jZexWGjl;
       spf=pass (google.com: domain of kernel-hardening-return-11627-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11627-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Jmo6kIv4;
       dkim=pass header.i=@chromium.org header.s=google header.b=jZexWGjl;
       spf=pass (google.com: domain of kernel-hardening-return-11627-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11627-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <123377.1517765678@turing-police.cc.vt.edu>
References: <123377.1517765678@turing-police.cc.vt.edu>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 6 Feb 2018 12:07:31 +1100
X-Google-Sender-Auth: uXzJmOkelSc8tgbmPjXG8gyUBmo
Message-ID: <CAGXu5jJYwtUwYWh9VfuZ7hydScoBaT3gWbjcN=TpnZsywYO3Ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] GCC release 8 support for gcc-plugins
To: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: kernel-hardening@lists.openwall.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591490625322246882?=
X-GMAIL-MSGID: =?utf-8?q?1591611773835516742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 4:34 AM,  <valdis.kletnieks@vt.edu> wrote:
> For reasons totally beyond my understanding, gcc 8 changed the
> order of two structure member, which leads to an error:
>
>   HOSTCXX -fPIC scripts/gcc-plugins/latent_entropy_plugin.o
> scripts/gcc-plugins/latent_entropy_plugin.c:269:1: error: designator order for field 'attribute_spec::affects_type_identity' does not match declaration order in 'attribute_spec'
>  };
>  ^

FWIW, my gcc 8 snapshot reports:

scripts/gcc-plugins/latent_entropy_plugin.c:269:1: sorry,
unimplemented: non-trivial designated initializers not supported
 };
 ^

But yeah, it seems that initializer _order_ matters here. Uuuugh.

I think instead of static initializers, we can just move this into the
register function, then order won't matter again. e.g.:


diff --git a/scripts/gcc-plugins/latent_entropy_plugin.c
b/scripts/gcc-plugins/latent_entropy_plugin.c
index 65264960910d..6836b8cd9fc4 100644
--- a/scripts/gcc-plugins/latent_entropy_plugin.c
+++ b/scripts/gcc-plugins/latent_entropy_plugin.c
@@ -255,21 +255,21 @@ static tree handle_latent_entropy_attribute(tree
*node, tree name,
        return NULL_TREE;
 }

-static struct attribute_spec latent_entropy_attr = {
-       .name                           = "latent_entropy",
-       .min_length                     = 0,
-       .max_length                     = 0,
-       .decl_required                  = true,
-       .type_required                  = false,
-       .function_type_required         = false,
-       .handler                        = handle_latent_entropy_attribute,
-#if BUILDING_GCC_VERSION >= 4007
-       .affects_type_identity          = false
-#endif
-};
+static struct attribute_spec latent_entropy_attr;

 static void register_attributes(void *event_data __unused, void *data __unused)
 {
+       latent_entropy_attr.name                        = "latent_entropy";
+       latent_entropy_attr.min_length                  = 0;
+       latent_entropy_attr.max_length                  = 0;
+       latent_entropy_attr.decl_required               = true;
+       latent_entropy_attr.type_required               = false;
+       latent_entropy_attr.function_type_required      = false;
+       latent_entropy_attr.handler     = handle_latent_entropy_attribute;
+#if BUILDING_GCC_VERSION >= 4007
+       latent_entropy_attr.affects_type_identity       = false;
+#endif
+
        register_attribute(&latent_entropy_attr);
 }

(pardon whitespace damage...)

-Kees

-- 
Kees Cook
Pixel Security
