Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbeBPTvl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:51:41 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:39205 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbeBPTvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:51:39 -0500
X-Google-Smtp-Source: AH8x226kyIY3dfCDZ/Fu98v5syRuD3OWgZ6oP/f7o4I9sp3sEcEVeaVoTf8gI/dknqCuiRNaCvL72gdrUdCrLa8JXyA=
MIME-Version: 1.0
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <CAKv+Gu80pJ5tbGoJqBm8CCKrEZXdkE83c944383KbQ5jREUC0Q@mail.gmail.com>
 <20180216105548.GA29042@pd.tnic> <CAKv+Gu8qm2wFxY56-eRLkLZB6fRUCmZbZo=4cvo5e4JDFh01Gg@mail.gmail.com>
 <20180216110821.GB29042@pd.tnic> <CAKv+Gu_SD6yWJMGbTwGUWXtrgZKPkpANNaGe1PUruTG9j0yhcg@mail.gmail.com>
 <20180216184832.sqreq5zhar3jqdae@jbkonno-saint14> <20180216192220.wljl23g533sc3oxg@redhat.com>
 <CAKv+Gu9=wny1J+-tZCdoGYUSZjfWgbiB9b_MdgpssdcTVXtKkA@mail.gmail.com>
In-Reply-To: <CAKv+Gu9=wny1J+-tZCdoGYUSZjfWgbiB9b_MdgpssdcTVXtKkA@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 16 Feb 2018 19:51:27 +0000
Message-ID: <CACdnJutpJa3nnH0Cs=x-=+GYp+9R5ZJkREhd7DvwDcmyjufSHA@mail.gmail.com>
Subject: Re: [PATCH 0/2] efivars: reading variables can generate SMIs
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: pjones@redhat.com, joe.konno@linux.intel.com, bp@alien8.de,
        mingo@kernel.org, luto@kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jk@ozlabs.org, ak@linux.intel.com, tony.luck@intel.com,
        benjamin.drung@profitbricks.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:31 AM Ard Biesheuvel <ard.biesheuvel@linaro.org>
wrote:
> This is why I was leaning towards applying these patches: not breaking
> userland is an important rule, but it does not imply every aspect of
> behavior observable by userland is set in stone. In other words, I
> agree with Peter that making this change does not *break* userland in
> a way anyone is likely to care deeply about.

In some modes tpmtotp will run as non-root and expect to be able to read an
EFI variable.
