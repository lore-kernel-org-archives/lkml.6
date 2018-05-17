Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeEQVIN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:08:13 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:43665 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeEQVIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:08:11 -0400
Message-ID: <1526591280.9159.176.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 159/190] ipsec: check return value of skb_to_sgvec
 always
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <natechancellor@gmail.com>
Date: Thu, 17 May 2018 22:08:00 +0100
In-Reply-To: <20180517091002.GH25318@kroah.com>
References: <20180411183550.114495991@linuxfoundation.org>
         <20180411183601.856116959@linuxfoundation.org>
         <1526479082.9159.120.camel@codethink.co.uk>
         <20180517091002.GH25318@kroah.com>
Organization: Codethink Ltd.
Content-Type: multipart/mixed; boundary="=-whUuwoWHN+d65Huw6Uyh"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-whUuwoWHN+d65Huw6Uyh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2018-05-17 at 11:10 +0200, Greg Kroah-Hartman wrote:
> On Wed, May 16, 2018 at 02:58:02PM +0100, Ben Hutchings wrote:
> > On Wed, 2018-04-11 at 20:36 +0200, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Jason A. Donenfeld <Jason@zx2c4.com>
> > > 
> > > commit 3f29770723fe498a5c5f57c3a31a996ebdde03e1 upstream.
> > 
> > [...]
> > 
> > This leaves the error paths in esp{4,6}.c leaking memory; fixed
> > upstream by:
> > 
> > commit e6194923237f3952b955c343b65b211f36bce01c
> > Author: Steffen Klassert <steffen.klassert@secunet.com>
> > Date:   Thu Jul 13 09:13:30 2017 +0200
> > 
> >     esp: Fix memleaks on error paths.
> 
> Really?  That patch doesn't apply at all.  It looks like this patch
> fixes things that happened after the above patch.
> 
> Or am I confused?

It's partly fixing bugs introduced in 4.12, but it's also fixing
similar bugs introduced by the commit that has been backported to
stable branches.

I've attached a backport to 4.4 that will also work for 4.9 (it has
identical versions of esp4 and esp6).  I would appreciate a review from
those actually familiar with the code.  Also, it looks like
esp6_input() still has a potential leak both upstream and in stable
branches.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.

--=-whUuwoWHN+d65Huw6Uyh
Content-Disposition: attachment; filename="0001-esp-Fix-memleaks-on-error-paths.patch"
Content-Type: text/x-patch; name="0001-esp-Fix-memleaks-on-error-paths.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBlNjE5NDkyMzIzN2YzOTUyYjk1NWMzNDNiNjViMjExZjM2YmNlMDFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmZmVuIEtsYXNzZXJ0IDxzdGVmZmVuLmtsYXNzZXJ0QHNl
Y3VuZXQuY29tPgpEYXRlOiBUaHUsIDEzIEp1bCAyMDE3IDA5OjEzOjMwICswMjAwClN1YmplY3Q6
IFtQQVRDSF0gZXNwOiBGaXggbWVtbGVha3Mgb24gZXJyb3IgcGF0aHMuCgpXZSBsZWFrIHRoZSB0
ZW1wb3JhcnkgYWxsb2NhdGVkIHJlc291cmNlcyBpbiBlcnJvciBwYXRocywKZml4IHRoaXMgYnkg
ZnJlZWluZyB0aGVtLgoKRml4ZXM6IGZjYTExZWJkZTNmICgiZXNwNDogUmVvcmdhbml6ZSBlc3Bf
b3V0cHV0IikKRml4ZXM6IDM4M2QwMzUwZjJjICgiZXNwNjogUmVvcmdhbml6ZSBlc3Bfb3V0cHV0
IikKRml4ZXM6IDNmMjk3NzA3MjNmICgiaXBzZWM6IGNoZWNrIHJldHVybiB2YWx1ZSBvZiBza2Jf
dG9fc2d2ZWMgYWx3YXlzIikKU2lnbmVkLW9mZi1ieTogU3RlZmZlbiBLbGFzc2VydCA8c3RlZmZl
bi5rbGFzc2VydEBzZWN1bmV0LmNvbT4KLS0tCiBuZXQvaXB2NC9lc3A0LmMgfCAxMyArKysrKysr
Ky0tLS0tCiBuZXQvaXB2Ni9lc3A2LmMgfCAgOSArKysrKy0tLS0KIDIgZmlsZXMgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvaXB2NC9l
c3A0LmMgYi9uZXQvaXB2NC9lc3A0LmMKaW5kZXggMGNiZWUwYTY2NmZmLi5kYmIzMWE5NDJkZmEg
MTAwNjQ0Ci0tLSBhL25ldC9pcHY0L2VzcDQuYworKysgYi9uZXQvaXB2NC9lc3A0LmMKQEAgLTM4
MSw3ICszODEsNyBAQCBpbnQgZXNwX291dHB1dF90YWlsKHN0cnVjdCB4ZnJtX3N0YXRlICp4LCBz
dHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgZXNwX2luZm8gKgogCQkgICAgICAgICAgICh1bnNp
Z25lZCBjaGFyICopZXNwaCAtIHNrYi0+ZGF0YSwKIAkJICAgICAgICAgICBhc3NvY2xlbiArIGl2
bGVuICsgZXNwLT5jbGVuICsgYWxlbik7CiAJaWYgKHVubGlrZWx5KGVyciA8IDApKQotCQlnb3Rv
IGVycm9yOworCQlnb3RvIGVycm9yX2ZyZWU7CiAKIAlpZiAoIWVzcC0+aW5wbGFjZSkgewogCQlp
bnQgYWxsb2NzaXplOwpAQCAtMzkyLDcgKzM5Miw3IEBAIGludCBlc3Bfb3V0cHV0X3RhaWwoc3Ry
dWN0IHhmcm1fc3RhdGUgKngsIHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBlc3BfaW5mbyAq
CiAJCXNwaW5fbG9ja19iaCgmeC0+bG9jayk7CiAJCWlmICh1bmxpa2VseSghc2tiX3BhZ2VfZnJh
Z19yZWZpbGwoYWxsb2NzaXplLCBwZnJhZywgR0ZQX0FUT01JQykpKSB7CiAJCQlzcGluX3VubG9j
a19iaCgmeC0+bG9jayk7Ci0JCQlnb3RvIGVycm9yOworCQkJZ290byBlcnJvcl9mcmVlOwogCQl9
CiAKIAkJc2tiX3NoaW5mbyhza2IpLT5ucl9mcmFncyA9IDE7CkBAIC00MDksNyArNDA5LDcgQEAg
aW50IGVzcF9vdXRwdXRfdGFpbChzdHJ1Y3QgeGZybV9zdGF0ZSAqeCwgc3RydWN0IHNrX2J1ZmYg
KnNrYiwgc3RydWN0IGVzcF9pbmZvICoKIAkJCSAgICAgICAgICAgKHVuc2lnbmVkIGNoYXIgKill
c3BoIC0gc2tiLT5kYXRhLAogCQkJICAgICAgICAgICBhc3NvY2xlbiArIGl2bGVuICsgZXNwLT5j
bGVuICsgYWxlbik7CiAJCWlmICh1bmxpa2VseShlcnIgPCAwKSkKLQkJCWdvdG8gZXJyb3I7CisJ
CQlnb3RvIGVycm9yX2ZyZWU7CiAJfQogCiAJaWYgKCh4LT5wcm9wcy5mbGFncyAmIFhGUk1fU1RB
VEVfRVNOKSkKQEAgLTQ0Miw4ICs0NDIsOSBAQCBpbnQgZXNwX291dHB1dF90YWlsKHN0cnVjdCB4
ZnJtX3N0YXRlICp4LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgZXNwX2luZm8gKgogCiAJ
aWYgKHNnICE9IGRzZykKIAkJZXNwX3NzZ191bnJlZih4LCB0bXApOwotCWtmcmVlKHRtcCk7CiAK
K2Vycm9yX2ZyZWU6CisJa2ZyZWUodG1wKTsKIGVycm9yOgogCXJldHVybiBlcnI7CiB9CkBAIC02
OTUsOCArNjk2LDEwIEBAIHNraXBfY293OgogCiAJc2dfaW5pdF90YWJsZShzZywgbmZyYWdzKTsK
IAllcnIgPSBza2JfdG9fc2d2ZWMoc2tiLCBzZywgMCwgc2tiLT5sZW4pOwotCWlmICh1bmxpa2Vs
eShlcnIgPCAwKSkKKwlpZiAodW5saWtlbHkoZXJyIDwgMCkpIHsKKwkJa2ZyZWUodG1wKTsKIAkJ
Z290byBvdXQ7CisJfQogCiAJc2tiLT5pcF9zdW1tZWQgPSBDSEVDS1NVTV9OT05FOwogCmRpZmYg
LS1naXQgYS9uZXQvaXB2Ni9lc3A2LmMgYi9uZXQvaXB2Ni9lc3A2LmMKaW5kZXggOWVkMzU0NzNk
Y2I1Li4zOTJkZWYxZmNmMjEgMTAwNjQ0Ci0tLSBhL25ldC9pcHY2L2VzcDYuYworKysgYi9uZXQv
aXB2Ni9lc3A2LmMKQEAgLTM0NSw3ICszNDUsNyBAQCBpbnQgZXNwNl9vdXRwdXRfdGFpbChzdHJ1
Y3QgeGZybV9zdGF0ZSAqeCwgc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IGVzcF9pbmZvCiAJ
CSAgICAgICAgICAgKHVuc2lnbmVkIGNoYXIgKillc3BoIC0gc2tiLT5kYXRhLAogCQkgICAgICAg
ICAgIGFzc29jbGVuICsgaXZsZW4gKyBlc3AtPmNsZW4gKyBhbGVuKTsKIAlpZiAodW5saWtlbHko
ZXJyIDwgMCkpCi0JCWdvdG8gZXJyb3I7CisJCWdvdG8gZXJyb3JfZnJlZTsKIAogCWlmICghZXNw
LT5pbnBsYWNlKSB7CiAJCWludCBhbGxvY3NpemU7CkBAIC0zNTYsNyArMzU2LDcgQEAgaW50IGVz
cDZfb3V0cHV0X3RhaWwoc3RydWN0IHhmcm1fc3RhdGUgKngsIHN0cnVjdCBza19idWZmICpza2Is
IHN0cnVjdCBlc3BfaW5mbwogCQlzcGluX2xvY2tfYmgoJngtPmxvY2spOwogCQlpZiAodW5saWtl
bHkoIXNrYl9wYWdlX2ZyYWdfcmVmaWxsKGFsbG9jc2l6ZSwgcGZyYWcsIEdGUF9BVE9NSUMpKSkg
ewogCQkJc3Bpbl91bmxvY2tfYmgoJngtPmxvY2spOwotCQkJZ290byBlcnJvcjsKKwkJCWdvdG8g
ZXJyb3JfZnJlZTsKIAkJfQogCiAJCXNrYl9zaGluZm8oc2tiKS0+bnJfZnJhZ3MgPSAxOwpAQCAt
MzczLDcgKzM3Myw3IEBAIGludCBlc3A2X291dHB1dF90YWlsKHN0cnVjdCB4ZnJtX3N0YXRlICp4
LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgZXNwX2luZm8KIAkJCSAgICAgICAgICAgKHVu
c2lnbmVkIGNoYXIgKillc3BoIC0gc2tiLT5kYXRhLAogCQkJICAgICAgICAgICBhc3NvY2xlbiAr
IGl2bGVuICsgZXNwLT5jbGVuICsgYWxlbik7CiAJCWlmICh1bmxpa2VseShlcnIgPCAwKSkKLQkJ
CWdvdG8gZXJyb3I7CisJCQlnb3RvIGVycm9yX2ZyZWU7CiAJfQogCiAJaWYgKCh4LT5wcm9wcy5m
bGFncyAmIFhGUk1fU1RBVEVfRVNOKSkKQEAgLTQwNiw4ICs0MDYsOSBAQCBpbnQgZXNwNl9vdXRw
dXRfdGFpbChzdHJ1Y3QgeGZybV9zdGF0ZSAqeCwgc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0
IGVzcF9pbmZvCiAKIAlpZiAoc2cgIT0gZHNnKQogCQllc3Bfc3NnX3VucmVmKHgsIHRtcCk7Ci0J
a2ZyZWUodG1wKTsKIAorZXJyb3JfZnJlZToKKwlrZnJlZSh0bXApOwogZXJyb3I6CiAJcmV0dXJu
IGVycjsKIH0KLS0gCjIuMTEuMAoK


--=-whUuwoWHN+d65Huw6Uyh--
