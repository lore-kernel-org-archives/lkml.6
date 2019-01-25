Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACF6C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0DD218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D22+NjvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfAYBcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 20:32:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35915 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbfAYBcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 20:32:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so7009636ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 17:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivsMZ6gUkEBmy2LkIHbFygoYqdG1ahU5/kfkzXuz0nc=;
        b=D22+NjvFX4R9GN44qTX9UVx01+xXSGDFYLr/daVvFLeWEs3B186M+c+YiQqg9uXd+T
         H8fqwJTkD0piK86KNRsIBL2RS89radUuTSOLAnK+mpyaUXpUOdUiTCS4aqi+G6IuCCdg
         XYErwj5i6+e6oEDlhMa/dh/nKhrPH2Gvwy+WW8tWw8OipofMadDE+o51DyUXIXuzx4uK
         3SA5FQXPgYtKNHkcp5u6RFYOpBPMjlAMQZKjLez88eOnAdWiiyaSYTlVWBYs1qmHLTVx
         /msHtkevF5PN1mAuFZ/zL1PaACaYM786LWROQPuFrP2PfqEtxPNhxCVhLeFFakVwkMS2
         nQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivsMZ6gUkEBmy2LkIHbFygoYqdG1ahU5/kfkzXuz0nc=;
        b=L0Mm6K/BoTPnY8IlZeSGujKFILERblQWQObxEI99Mskxp+5HpTCBlgP1MiTYWlAld0
         TKikTJFoBoeaouzHwXoyJwSN6jtBh4E7mFOqQP3yf8XhNFilSQ01I0fgF8DDHVz6/rsK
         amHlUQjh5TJvltuDZkvyfPtnVroy0hnrMPFuPT6ggCNYtOoc/t9ek+iJNVer0TqGNKLP
         aFH3PS/d1mPyhia6QKT0XoYB5veKGRxCd0vct5YddQPh5fRXyjgNDZM793SqxvH/MfJP
         KMGrxTGftsqR8zzeDVqm/C5b0xxH8z6mHNmqibLZ+t7WdDyoC2cayBoqwcuaS/GV94/K
         o32Q==
X-Gm-Message-State: AJcUukeWzfZxt/U7iRnwqYel8vsD1Badz3tS7oUUUN6zpVeH/7aqv9MO
        E5kHQlgL7PicWu2dSFa8T2oeBEr0rndSSXKfXaW+ZA==
X-Google-Smtp-Source: ALg8bN4ehrIK3406rutcZkmYLXU5SC6i8UlLUDqKgzGGJP2Jsel1fckaF3VsSspB4SidKCR+fXo618nAMH2kuJePtJY=
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr6437733lja.19.1548379971021;
 Thu, 24 Jan 2019 17:32:51 -0800 (PST)
MIME-Version: 1.0
References: <20190115211137.rhdyjadu7fppp3p4@lenny.lan> <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com> <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
 <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
 <c6721670-cf89-5d21-953d-c1fa10d87367@linux.intel.com> <CAOReqxgG4TJDXKCEVcDVXvpi_mnLUzqLwF7Rp0H5iAPdbMuZ_Q@mail.gmail.com>
 <44029078-2749-5a3b-7b03-f38461bf268f@linux.intel.com> <20190124184412.GH5641@sirena.org.uk>
 <976ec85a-7b21-6c58-90cc-a3d104f9505a@linux.intel.com> <20190124192652.GK5641@sirena.org.uk>
In-Reply-To: <20190124192652.GK5641@sirena.org.uk>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Fri, 25 Jan 2019 09:32:38 +0800
Message-ID: <CAOReqxgow+f=LCQ++JM7npFC5nzU_aEhCV72n6A-jhRsJaPybw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, Vinod Koul <vinod.koul@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, plai@codeaurora.org,
        linux-kernel@vger.kernel.org, Ajit Pandey <ajitp@codeaurora.org>,
        tiwai@suse.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Matthias Reichl <hias@horus.com>,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Dylan Reid <dgreid@google.com>
Content-Type: multipart/mixed; boundary="0000000000002711a205803e4eae"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002711a205803e4eae
Content-Type: text/plain; charset="UTF-8"

I have a patch to fix the memory leak but I haven't been able to test
it yet because I am remote right now and I accidentally bootlooped the
AMD device I am working on. I will have this tested early next week.
Here is the patch for anyone interested.

Curtis Malainey | Software Engineer | cujomalainey@google.com | 650-898-3849


On Fri, Jan 25, 2019 at 3:26 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jan 24, 2019 at 01:07:17PM -0600, Pierre-Louis Bossart wrote:
>
> > Thanks for the feedback, will send a formal patch with the helper and
> > machine driver changes after I test more with the legacy drivers. Do you
> > have a preference for one patch that deals with multiple machines drivers in
> > one shot, or individual patches? The latter are nicer for backports (e.g.
> > for Chrome), the former nicer for maintainers...
>
> More patches is good, it doesn't make a huge difference if I get one big
> patch or a series of repetitive patches - big serieses are more of an
> issue if they're all different patches needing individual review.

--0000000000002711a205803e4eae
Content-Type: application/octet-stream; 
	name="0001-ASoC-soc-core-clear-platform-pointers-on-error.patch"
Content-Disposition: attachment; 
	filename="0001-ASoC-soc-core-clear-platform-pointers-on-error.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jrbdeby40>
X-Attachment-Id: f_jrbdeby40

RnJvbSBmNWEyMmFlMzc2MTg4ZWUxYWQ1NGVmZDEyNzQ5NDAyOTUyNDVlZWYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDdXJ0aXMgTWFsYWluZXkgPGN1am9tYWxhaW5leUBjaHJvbWl1
bS5vcmc+CkRhdGU6IFR1ZSwgMjIgSmFuIDIwMTkgMjE6MjM6MjEgLTA4MDAKU3ViamVjdDogW1BB
VENIXSBBU29DOiBzb2MtY29yZTogY2xlYXIgcGxhdGZvcm0gcG9pbnRlcnMgb24gZXJyb3IKCk9y
aWdpbmFsbHkgc25kX3NvY19pbml0X3BsYXRmb3JtIHdhcyBub3QgY2xlYW5pbmcgdXAgaXRzIHBv
aW50ZXJzLCB0aGlzCndhcyBmaXhlZCB0byBhbHdheXMgcmVhbGxvY2F0ZSBkeW5hbWljIG1lbW9y
eSBidXQgY3JlYXRlZCBhIG1lbW9yeSBsZWFrCndoZW4gc25kX3NvY19pbml0X3BsYXRmb3JtIHdh
cyBjYWxsZWQgbXVsdGlwbGUgdGltZXMgZHVyaW5nIHRoZSBzYW1lCnByb2JlIGF0dGVtcHQgYW5k
IGFsc28gdGhyZXcgYXdheSBhbnkgY2hhbmdlcyBtYWRlIHRvIHRoZSBzdHJ1Y3QgYmV0d2Vlbgpj
YWxscy4gSW4gb3JkZXIgdG8gYWNvaWQgcmVhbGxvY2F0aW5nIG1lbW9yeSB0aGF0IGlzIHN0aWxs
IHZhbGlkLCB0aGUKYmVoYXZpb3VyIHdpbGwgYmUgY2hhbmdlZCB0byBjbGVhciB0aGUgZHluYW1p
Y2FsbHkgc2V0IHBvaW50ZXJzIG9uIGEKcHJvYmUgZXJyb3IgYW5kIGEgdW5yZWdpc3RlciBldmVu
dCBhbmQgc25kX3NvY19pbml0X3BsYXRmb3JtIHdpbGwgZ28KYmFjayB0byBpdHMgb3JpZ2luYWwg
YmVoYXZpb3VyIG9mIG9ubHkgYWxsb2NhdGluZyBudWxsIHBvaW50ZXJzIHNvIGl0IHdpbGwKc3Rv
cCB0aHJvd2luZyBhd2F5IHZhbGlkIGNoYW5nZXMuCgpDaGFuZ2UtSWQ6IEliZGVhYzA0MTg2OGRl
YzA5NTU4OGNkMzM5ZTI0OTk1NjllMzVlZjVjClNpZ25lZC1vZmYtYnk6IEN1cnRpcyBNYWxhaW5l
eSA8Y3Vqb21hbGFpbmV5QGNocm9taXVtLm9yZz4KLS0tCiBzb3VuZC9zb2Mvc29jLWNvcmUuYyB8
IDIxICsrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvc29jLWNvcmUuYyBiL3Nv
dW5kL3NvYy9zb2MtY29yZS5jCmluZGV4IDhhNThmYTg2Njc1YS4uYjczNTRlYTQ3MjVlIDEwMDY0
NAotLS0gYS9zb3VuZC9zb2Mvc29jLWNvcmUuYworKysgYi9zb3VuZC9zb2Mvc29jLWNvcmUuYwpA
QCAtMTA0OSw3ICsxMDQ5LDcgQEAgc3RhdGljIGludCBzbmRfc29jX2luaXRfcGxhdGZvcm0oc3Ry
dWN0IHNuZF9zb2NfY2FyZCAqY2FyZCwKIAkgKglzb2MuaCA6OiBzdHJ1Y3Qgc25kX3NvY19kYWlf
bGluawogCSAqLwogCS8qIGNvbnZlcnQgTGVnYWN5IHBsYXRmb3JtIGxpbmsgKi8KLQlpZiAoIXBs
YXRmb3JtIHx8IGRhaV9saW5rLT5sZWdhY3lfcGxhdGZvcm0pIHsKKwlpZiAoIXBsYXRmb3JtKSB7
CiAJCXBsYXRmb3JtID0gZGV2bV9remFsbG9jKGNhcmQtPmRldiwKIAkJCQlzaXplb2Yoc3RydWN0
IHNuZF9zb2NfZGFpX2xpbmtfY29tcG9uZW50KSwKIAkJCQlHRlBfS0VSTkVMKTsKQEAgLTEwNzIs
NiArMTA3MiwyNCBAQCBzdGF0aWMgaW50IHNuZF9zb2NfaW5pdF9wbGF0Zm9ybShzdHJ1Y3Qgc25k
X3NvY19jYXJkICpjYXJkLAogCXJldHVybiAwOwogfQogCitzdGF0aWMgdm9pZCBzb2NfY2xlYW51
cF9wbGF0Zm9ybShzdHJ1Y3Qgc25kX3NvY19jYXJkICpjYXJkKQoreworCXN0cnVjdCBzbmRfc29j
X2RhaV9saW5rICpsaW5rOworCWludCBpOworCS8qCisJICogRklYTUUKKwkgKgorCSAqIHRoaXMg
ZnVuY3Rpb24gc2hvdWxkIGJlIHJlbW92ZWQgd2l0aCBzbmRfc29jX2luaXRfcGxhdGZvcm0KKwkg
Ki8KKworCWZvcl9lYWNoX2NhcmRfcHJlbGlua3MoY2FyZCwgaSwgbGluaykgeworCQlpZiAobGlu
ay0+bGVnYWN5X3BsYXRmb3JtKSB7CisJCQlsaW5rLT5sZWdhY3lfcGxhdGZvcm0gPSAwOworCQkJ
bGluay0+cGxhdGZvcm1zICAgICAgID0gTlVMTDsKKwkJfQorCX0KK30KKwogc3RhdGljIGludCBz
bmRfc29jX2luaXRfbXVsdGljb2RlYyhzdHJ1Y3Qgc25kX3NvY19jYXJkICpjYXJkLAogCQkJCSAg
IHN0cnVjdCBzbmRfc29jX2RhaV9saW5rICpkYWlfbGluaykKIHsKQEAgLTIwMTYsNiArMjAzNCw3
IEBAIHN0YXRpYyBpbnQgc29jX2NsZWFudXBfY2FyZF9yZXNvdXJjZXMoc3RydWN0IHNuZF9zb2Nf
Y2FyZCAqY2FyZCkKIAkvKiByZW1vdmUgYW5kIGZyZWUgZWFjaCBEQUkgKi8KIAlzb2NfcmVtb3Zl
X2RhaV9saW5rcyhjYXJkKTsKIAlzb2NfcmVtb3ZlX3BjbV9ydW50aW1lcyhjYXJkKTsKKwlzb2Nf
Y2xlYW51cF9wbGF0Zm9ybShjYXJkKTsKIAogCS8qIHJlbW92ZSBhdXhpbGlhcnkgZGV2aWNlcyAq
LwogCXNvY19yZW1vdmVfYXV4X2RldmljZXMoY2FyZCk7Ci0tIAoyLjIwLjEuMzIxLmc5ZTc0MDU2
OGNlLWdvb2cKCg==
--0000000000002711a205803e4eae--
