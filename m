Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753479AbeBKOhq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 09:37:46 -0500
Received: from mail-pl0-f42.google.com ([209.85.160.42]:46253 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbeBKOho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 09:37:44 -0500
X-Google-Smtp-Source: AH8x224Im8njRiPMxxrTEMQTcbAic0fmfWUjBeHXzPfBrdsgvNKffZu24wdj5Nin9jaxgoZPU3Wisg==
From: Geliang Tang <geliangtang@gmail.com>
To: Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: add lz4hc and 842 compression support 
Date: Sun, 11 Feb 2018 22:37:30 +0800
Message-Id: <cover.1518356301.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <CAGXu5jL+CWgMpBzhOwro7qo=a9kHhSGqp+EDMqKv23k7FOFUzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2017 at 05:44:52PM -0800, Kees Cook wrote:
> > +
> > +       ret = LZ4_compress_default(in, out, inlen, outlen, workspace);
> > +       if (!ret) {
> > +               pr_err("LZ4_compress_default error; compression failed!\n");
> > +               return -EIO;
> > +       }
> > +
> > +       return ret;
> 
> Other compress/decompress return outlen, rather than ret. Is "ret" the
> outlen here?
> 

> > +
> > +       ret = LZ4_compress_HC(in, out, inlen, outlen,
> > +                             LZ4HC_DEFAULT_CLEVEL, workspace);
> > +       if (!ret) {
> > +               pr_err("LZ4_compress_HC error; compression failed!\n");
> > +               return -EIO;
> > +       }
> > +
> > +       return ret;
> 
> And here?
> 

Yes, ret is outlen in LZ4_compress_default and LZ4_compress_HC.

> > +
> > +       ret = sw842_compress(in, inlen, out, &len, workspace);
> > +       if (!ret) {
> > +               pr_err("sw842_compress error; compression failed!\n");
> > +               return -EIO;
> > +       }
> > +       outlen = len;
> 
> This has no effect. What was intended?
> 

> > +       ret = sw842_decompress(in, inlen, out, &len);
> > +       if (ret < 0) {
> > +               pr_err("sw842_decompress error, ret = %d!\n", ret);
> > +               return -EIO;
> > +       }
> > +       outlen = len;
> 
> Same.
> 

I fixed them in patch v3.

> 
> Otherwise this all looks good. Thanks!
> 
> -Kees
> 
> -- 
> Kees Cook
> Pixel Security

Geliang Tang (1):
  pstore: add lz4hc and 842 compression support

 fs/pstore/Kconfig    |  25 +++++++++
 fs/pstore/platform.c | 147 ++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 154 insertions(+), 18 deletions(-)

-- 
2.14.1
