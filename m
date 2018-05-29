Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1258902-1527554359-2-4623355727901861367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527554358; b=id3iHuzWpZ/8UNpDR67o4KtDM5rR86ZpGEAVP6yDFOso8O6Tqk
    mVQL9y8PFXfQQEtKUAXbChzhdIQLs8NV+GOgjNU/Jy38LKXBn4sKQjY3xl8nZS4Z
    230HoyJdhCxTwOnaK5rxiCI0cP4fVCc2xThOYV71Qpvcdw5aFRDi2dsJaiZtxVux
    +mFa0YFAbJynFC2q+eaLCMXPxU9abpDRnp6ONN09Qn3BYrRGYIyrQ0ZA4yDmbSjS
    Zeaf4EYogF6DCmC+UXOlovzHw9YDJHerIJquzcHMXGPAVi4s3iXCezc4wm5RMjCr
    ylPrFSIKzk5RVpvTdEiUGXwu28praQbeRzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1527554358; bh=WFIK0mwJ4ug
    //CdGnEHhJ8Z/2TxhhFyk8Uizrx70ICg=; b=Pypxu6NeK+OcBDxI28ai8Y1MHSC
    9LQoQlBluVu8jDT8hXCmjmfa+QJAYxWIp7XVtxRndNWMF53qOkdu7E64LRLCua4d
    VM8xVAmnDJljupi8lyMB5815h+clgzjrf+KuzRUSfe2f0H18xP+f7KzwCMiyJ0DO
    g2xN2EuOTF61QPuPSKivvP4tJY1bP0ND2Y1+RJ3dJNWOngyZi6s7U44xT0RkA6fh
    rknZgZR0wiwVe1GgejHEpnSlFv3EurZsHWTv0ErOVb0b9tG8bkqE2G5f/mVoASDX
    CT4WaleqZdXrtJFNVF7GkQ3TT1WFMGyGSh1ci8KzSE0eiU0lcleA9AhIzSA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=tW6TyK8C header.a=rsa-sha256
    header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=PVMbAbbF;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=tW6TyK8C header.a=rsa-sha256
      header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=PVMbAbbF;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF1HbGzO+lqyYCNDmAGJOVoesNuqDPMqV88ptl/gOKqtRkK0HYNXETUtIfYOsjGGcn76Q/9Qa6O4sy2VOL4SpH27FoIdFpKBSeSvqzatHCfqyx9Hq3oP
    dOjyaVam6RQ0PC6xytC6sSScyM5mjs3gEDisDXwFDX+/+SqZM3D3YOPF43hpjUoZJWLiEGnftVXkGwhKN7AW0UkJBHFQEWFzSxhLShWInxeOIfAGo7SzJ96C
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=JjWJYW1LPTgA:10 a=VUJBJC2UJ8kA:10 a=aMy3mnA2XTC8uRcIcrYA:9
    a=3Qb_8jRFGzJARaB1:21 a=9yPgTp8bgLaPOqWK:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754511AbeE2AjF (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 20:39:05 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32859 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754415AbeE2AjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 May 2018 20:39:04 -0400
X-Google-Smtp-Source: AB8JxZoVaYOWAN3sqzFI2T5mUmbe23+VmkD2bpaN7BWpzBII7tMG3mnDJ0xh6nH0hm/xPfXe4W8fxA==
Date: Tue, 29 May 2018 09:24:56 +0900
From: Jungsub Shin <supsup5642@gmail.com>
To: "J. R. Okajima" <hooanon05g@gmail.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, aufs-users@lists.sourceforge.net
Subject: Re: Why is the length of max mount option a page size??
Message-ID: <20180529002456.GA30767@supsup-VirtualBox>
References: <20180521173959.GA12779@supsup-VirtualBox>
 <5670.1527244930@jrobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5670.1527244930@jrobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 25, 2018 at 07:42:10PM +0900, J. R. Okajima wrote:
> Jungsub Shin:
> > I know that almost mount option short and page size is enough to
> > contain almost mount options. but because of options for=20
> > unionfs(overlay, aufs), lenght of mount option could be exceed it
> > and cut.
> >
> > I suffer this problem with aufs. aufs's branch option is cut and=20
> > fail to aufs mount. I know that aufs is not offical fs in linux,=20
>=20
> For aufs, it should not happen because of the module parameter 'brs.'
>=20
> (from the aufs manual)
> ----------------------------------------------------------------------
> .SH Module Parameters
> .TP
> .B brs=3D1 | 0
> Specifies to use the branch path data file under sysfs or not.
>=20
> If the number of your branches is large or their path is long
> and you meet the limitation of mount(8) ro /etc/mtab, you need to
> enable CONFIG_SYSFS and set aufs module parameter brs=3D1.
>=20
> When this parameter is set as 1, aufs does not show `br:' (or dirs=3D)
> mount option through /proc/mounts (and /etc/mtab). So you can
> keep yourself from the page limitation of
> mount(8) or /etc/mtab.
> Aufs shows branch paths through <sysfs>/fs/aufs/si_XXX/brNNN.
> Actually the file under sysfs has also a size limitation, but I don't
> think it is harmful.
>=20
> There is one more side effect in setting 1 to this parameter.
> If you rename your branch, the branch path written in /etc/mtab will be
> obsoleted and the future remount will meet some error due to the
> unmatched parameters (Remember that mount(8) may take the options from
> /etc/mtab and pass them to the systemcall).
> If you set 1, /etc/mtab will not hold the branch path and you will not
> meet such trouble. On the other hand, the entries for the
> branch path under sysfs are generated dynamically. So it must not be obso=
leted.
> But I don't think users want to rename branches so often.
>=20
> If CONFIG_SYSFS is disable, this parameter is always set to 0.
> ----------------------------------------------------------------------
>=20
>=20
> If you post the details of your environment to aufs-users ML, then I
> may be able to describe more.
>=20
>=20
> J. R. Okajima

I think brs module option is irrelevant to this issue. brs module
option looks like that didn't affect passing option parameter with in=20
mount() system call.

I suffered this problem below environments.
------------------------------------------------------------------------
OS : Ubuntu 18.04 LTS / 4.15.0-20-generic / 64bit
AUFS module parameter : brs =3D 1 / allow_userns =3D N
Mount command : mount -t aufs -o br=3D~/tca_agent/container_rw_dir/51509032=
=3Drw:~/tca_agent/image_layer_dir/5a259d94211e449fd466d997b5b0b149cb2997a73=
2fd3a838c14295e0eb93f92=3Dro+wh:~/tca_agent/image_layer_dir/faca908333f8846=
48b75738571879df977339ee7615c65410c98001a463bcd00=3Dro+wh:~/tca_agent/image=
_layer_dir/67b50813aedeb67fd06b434163fa64d07fbd16f714196daea1cd139a0171b080=
=3Dro+wh:~/tca_agent/image_layer_dir/28b6f7699be037b7f80dd03b22830712aa75b8=
8ddfbba0910dd059b522fbff20=3Dro+wh:~/tca_agent/image_layer_dir/c47c7125efa9=
172d262c5b3645594010704f67cf44005da9f6d7ea5a5d2a05db=3Dro+wh:~/tca_agent/im=
age_layer_dir/b91ed1b448ac52d251c785f5cfc299ca3ba4cfd68d739832b766228afa84a=
651=3Dro+wh:~/tca_agent/image_layer_dir/0169cd8bc0bdbecedb30c7d995e69e832d7=
ccd5c435e72c40af6940db87851b7=3Dro+wh:~/tca_agent/image_layer_dir/e7ef7d443=
e31f8b3b8a0a002a6895746d3737289eb2eea18d669924c089279f2=3Dro+wh:~/tca_agent=
/image_layer_dir/31bfb0cd724fda09280305b8dc1c4b0587ca01f5dd503d28afa82cff4f=
a92475=3Dro+wh:~/tca_agent/image_layer_dir/74428f0d76521fa9b9b1189cb72d303e=
367003c113cc8a11db125e3f7df1daa1=3Dro+wh:~/tca_agent/image_layer_dir/b20a92=
7da14045cac0cd6a745f67fdeb88ead6d85752c670ea2773b27387f6ae=3Dro+wh:~/tca_ag=
ent/image_layer_dir/7dee3bce119631e3c922d78860d6b0ae160e237b63bf19f43713a05=
d1086c72f=3Dro+wh:~/tca_agent/image_layer_dir/636bce8f18e8734cb98f170bdcf1f=
b9ae52f1b091bfadcb2bef378b0d829ceb6=3Dro+wh:~/tca_agent/image_layer_dir/9c6=
fde234e701cf7b61534ef3a23cc4e0cdb6d3ffc497feaa8fcddc52e8d1fda=3Dro+wh:~/tca=
_agent/image_layer_dir/83c2f1968a932e3e284ef20b10a4ef8a9cfc01589dacf2100fb9=
a78e88c3888e=3Dro+wh:~/tca_agent/image_layer_dir/ec096a351601040fcd37c31edc=
cd2f68106438097e8adf7253539366b2232de5=3Dro+wh:~/tca_agent/image_layer_dir/=
6de889accecb819028355196bde150749598e982b5dfe556540e102c737bfc34=3Dro+wh:~/=
tca_agent/image_layer_dir/1042cb8f2263d1030fdb57e0ca671b34a2180bb35d9448737=
e4a03e4987cf942=3Dro+wh:~/tca_agent/image_layer_dir/4fab8c997a447af2375e325=
467661ca1d74bf62dc6d802426f20d0134c9c43bc=3Dro+wh:~/tca_agent/image_layer_d=
ir/ca57efb1c28464fab46af1826243c02af0a0b6cfb90bf92b30110e79028c5e68=3Dro+wh=
:~/tca_agent/image_layer_dir/ad86d54176611b5117fc155e8dfbd0b59bc0abce4e2051=
baef12c2f1e152c92f=3Dro+wh:~/tca_agent/image_layer_dir/f323ae7b264dcc517876=
e7c722ac3369baaef1a7c18cc5aae5f43f440fd646c0=3Dro+wh:~/tca_agent/image_laye=
r_dir/a7d1c89c8422563102bd353de46154191038f92c9ebde8b22a8b2749140029ec=3Dro=
+wh:~/tca_agent/image_layer_dir/104adb8634902678f87db6bdbdb12d43d5bd6db9909=
ae9b12e078286046a1298=3Dro+wh:~/tca_agent/image_layer_dir/00450b5308ac99846=
ae7e5fa47652952c4fbbe82882ac241d5153d630644f790=3Dro+wh:~/tca_agent/image_l=
ayer_dir/129675caf5fdc1616c619d5b5718417806a64f282d324a3a580d6df1269b4f3f=
=3Dro+wh:~/tca_agent/image_layer_dir/8ce8b37ab4829a1fd34fcd38842b912d46eb3f=
7511365ccec0399a06670ab2fc=3Dro+wh:~/tca_agent/image_layer_dir/57080e2e0baa=
d381605079107f08435133d7829364a9c450fc08877f01e57601=3Dro+wh:~/tca_agent/im=
age_layer_dir/9ca225075a8c2bfd27ef5084e41335d781d24e7be0cbf4575ec3d42de662c=
6ac=3Dro+wh:~/tca_agent/image_layer_dir/74ec3835691908f9e6e271797f373257de3=
f9cc4bb408fd66dd229537ea5fcc1=3Dro+wh:~/tca_agent/image_layer_dir/59aa8f04c=
38abaae9c0e430d7b1a91f6560641e429386ee2c4eec57f0af35c04=3Dro+wh:~/tca_agent=
/image_layer_dir/bc318ac48b4f7a9536b72e2b0f223726a5225e13ecc70eba4b7b00e2bf=
80081b=3Dro+wh:~/tca_agent/image_layer_dir/bbfb0e8818be82ca0f17f280f7ad8949=
7fef6c92e2bb50c40b2bd17c79347425=3Dro+wh:~/tca_agent/image_layer_dir/f36b94=
436263ce21d885d2f3f94c7b307e966a989fcefd3027c039e987d7dc2b=3Dro+wh:~/tca_ag=
ent/image_layer_dir/9103dae307f5748103f89093273329a523300b4f103a1d397c44abd=
766fe0015=3Dro+wh:~/tca_agent/image_layer_dir/9bd48cc89c1fc083b0db7ed45e5d7=
e4fec277450b8b47f96884588930ce8c56f=3Dro+wh:~/tca_agent/image_layer_dir/47b=
a0411cc8344ab1895a6b8eb0878a9ffd34410170a140ad1f210f20eedcdce=3Dro+wh:~/tca=
_agent/image_layer_dir/42b317de582399eb395b2818b4d658fb0a5987e8df1163e49ac2=
d8bec95a078e=3Dro+wh:~/tca_agent/image_layer_dir/57bb07a87ab6c29b048638c655=
66febe800fe79672730f7bb9e70b8f2e677e5a=3Dro+wh:~/tca_agent/image_layer_dir/=
b89b49aa036df19c6a2e77cc4aaef707ab3fd916d2d936b9e5e160d448d96ab3=3Dro+wh:~/=
tca_agent/image_layer_dir/d7bf931f8235cc7cc68c223b2945f77e858eb8cff4c9cb8bd=
64bacfd29312672=3Dro+wh:~/tca_agent/image_layer_dir/49a8b40dbec97066dbad4fb=
14d1bf388102190442679527e112b030270426ccc=3Dro+wh:~/tca_agent/image_layer_d=
ir/05f05d402ea8ee67da1af2c9e35d10b9619b0f0c14a56788a1a0b5eeb290d685=3Dro+wh=
:~/tca_agent/image_layer_dir/b05d3f32ac4ff52a542dfcf50dbf155d060d79bd23d0eb=
ed1439a3c6b1120731=3Dro+wh:~/tca_agent/image_layer_dir/0d061258f32c904c95aa=
020a9f679790c5722c3017eef98e298d6e29b4f02089=3Dro+wh:~/tca_agent/image_laye=
r_dir/1f9c07049bcd59c59413c1706d0402b04c96598174eb16ef3de25b4e47413ad2=3Dro=
+wh:~/tca_agent/image_layer_dir/a86578a8bff61017b80eb653705c3f41136efb9b88f=
acd6a2c67e8b3426e47f9=3Dro+wh:~/tca_agent/image_layer_dir/c3fdf4a694f0cc039=
39ee2cfdd09fb623966c5bb193778eaaea317655773656e=3Dro+wh:~/tca_agent/image_l=
ayer_dir/1b8fcd446a37050b55f57687aaae1150d74cc7f4468bbd00942535bad5ab22fe=
=3Dro+wh:~/tca_agent/image_layer_dir/6624cfa732b528cf7c1996719e30d1525aa27a=
f7584f61a149d4d386aa8cf301=3Dro+wh:~/tca_agent/image_layer_dir/5b57e87f9b58=
59d902c4338c7a7ce5996a51fb8226a8f11ab29e10af4af5f14f=3Dro+wh:~/tca_agent/im=
age_layer_dir/0c65112ac5c572a950e2671f903ef11e918e6e3cdbf026edda90db6c7a9c6=
ef8=3Dro+wh:~/tca_agent/image_layer_dir/ce16b72d243b82ded684a547da1400b8f2d=
07ed7b36b114ae0cbe2f20c17b0bf=3Dro+wh:~/tca_agent/image_layer_dir/a3937b112=
d7dbedfe075162862e404b7b85803d880589eaf3ebad9855629bdd5=3Dro+wh:~/tca_agent=
/image_layer_dir/b486d646cd9f5b8151856133ea3e81d53c3664bb727a0a87d0197cbbae=
9211de=3Dro+wh:~/tca_agent/image_layer_dir/de1b712fcfedbc3f61248c1a5fb9cba5=
a5ab6c7415f2c71c7ea162fd7c738c6f=3Dro+wh:~/tca_agent/image_layer_dir/2958a8=
58559d3091b8162c066cfe5e17012f2307772180e702ffbc89bcae8fc2=3Dro+wh:~/tca_ag=
ent/image_layer_dir/14eae848ef41eb275ad37cc9d12dc276d3f08beeb06e041407371b9=
489335ee1=3Dro+wh:~/tca_agent/image_layer_dir/d72e07c403501a4abefaa80f3b811=
21392c42f314fc14bbf1bb434dc84457dd5=3Dro+wh:~/tca_agent/image_layer_dir/ee0=
efde24e35b4e2f801ca25640169ca2f319f9b5d37dbb0917cfd43e818d1f4=3Dro+wh:~/tca=
_agent/image_layer_dir/67dfb4d7c7ce39829d36740e1ef5279e00320a0d2bfe06bb67b6=
571f1ff47627=3Dro+wh:~/tca_agent/image_layer_dir/b3a1a69310f719755232ed5f85=
09f11f549d620d723ea293f001e3d30795108b=3Dro+wh:~/tca_agent/image_layer_dir/=
a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4=3Dro+wh:~/=
tca_agent/image_layer_dir/e5ad7970bc69d2ba62d2bbb4b80627273350e1982ff43bc1c=
a04a3215bc6da5b=3Dro+wh none ~/tca_agent/container_root_dir/51509032
dmesg : [343090.744067] aufs opt_add:810:mount[30864]: lookup failed /root/=
tca_agent/image_layer_di (-2)
------------------------------------------------------------------------

br option is cut and aufs search cut directory. Length of mount option
is about 6400. So I tested again with reduced option to about 4000=20
characters (PAGE_SIZE 4096 in kernel) by reducing branches, AUFS works well.

So I looked copy_mount_options() function in the kernel. This function
copys mount option form user memory to kernel memory within PAGE_SIZE(4096).
