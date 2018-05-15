Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbeEOUW0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:22:26 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:43276 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeEOUWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:22:25 -0400
From: Richard Weinberger <richard@nod.at>
To: David Oberhollenzer <goliath@sigma-star.at>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] libubigen: Maintain a eraseblock association table
Date: Tue, 15 May 2018 22:22:16 +0200
Message-ID: <5480742.m6jlgxS7AR@blindfold>
In-Reply-To: <cc8f9abd-42b7-cc71-b89c-92c5cbd84aa3@sigma-star.at>
References: <20180514112528.24092-1-richard@nod.at> <20180514112528.24092-5-richard@nod.at> <cc8f9abd-42b7-cc71-b89c-92c5cbd84aa3@sigma-star.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 15. Mai 2018, 21:58:01 CEST schrieb David Oberhollenzer:
> On 05/14/2018 01:25 PM, Richard Weinberger wrote:
> > @@ -229,6 +234,12 @@ int ubigen_write_volume(const struct ubigen_info *ui,
> >  		memset(outbuf + ui->data_offs + len, 0xFF,
> >  		       ui->peb_size - ui->data_offs - len);
> >  
> > +		vi->eba[lnum] = lseek(out, 0, SEEK_CUR) / ui->peb_size;
> > +		if (vi->eba[lnum] == -1) {
> > +			sys_errmsg("cannot get offset of output file");
> > +			goto out_free1;
> > +		}
> > +
> >  		if (write(out, outbuf, ui->peb_size) != ui->peb_size) {
> >  			sys_errmsg("cannot write %d bytes to the output file", ui->peb_size);
> >  			goto out_free1;
> 
> Wouldn't that division swallow errors? If I interpret the C99 draft correctly, dividing
> an lseek return value of -1 by ui->peb_size > 1 should result in 0.

Yep, that needs fixing.

Thanks,
//richard
