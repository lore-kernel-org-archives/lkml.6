Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeE2EMa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 00:12:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:32856 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeE2EM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 00:12:26 -0400
X-Google-Smtp-Source: AB8JxZo+pFjIhBSqYeC+lsAxfkqSb0Yn6t5OA9XyQiyHk3h6g0IbACDQde9iOBGNyWfRrIBNAKL/Yw==
Date: Tue, 29 May 2018 12:57:03 +0900
From: Jungsub Shin <supsup5642@gmail.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: "J. R. Okajima" <hooanon05g@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, aufs-users@lists.sourceforge.net
Subject: Re: Why is the length of max mount option a page size??
Message-ID: <20180529035703.GA32550@supsup-VirtualBox>
References: <20180521173959.GA12779@supsup-VirtualBox>
 <5670.1527244930@jrobl>
 <20180529002456.GA30767@supsup-VirtualBox>
 <20180529011412.GE30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529011412.GE30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4T4CjYd023346

On Tue, May 29, 2018 at 02:14:12AM +0100, Al Viro wrote:
> On Tue, May 29, 2018 at 09:24:56AM +0900, Jungsub Shin wrote:
> > Mount command : mount -t aufs -o br=~/tca_agent/container_rw_dir/51509032=rw:~/tca_agent/image_layer_dir/5a259d94211e449fd466d997b5b0b149cb2997a732fd3a838c14295e0eb93f92=ro+wh:~/tca_agent/image_layer_dir/faca908333f884648b75738571879df977339ee7615c65410c98001a463bcd00=ro+wh:~/tca_agent/image_layer_dir/67b50813aedeb67fd06b434163fa64d07fbd16f714196daea1cd139a0171b080=ro+wh:~/tca_agent/image_layer_dir/28b6f7699be037b7f80dd03b22830712aa75b88ddfbba0910dd059b522fbff20=ro+wh:~/tca_agent/image_layer_dir/c47c7125efa9172d262c5b3645594010704f67cf44005da9f6d7ea5a5d2a05db=ro+wh:~/tca_agent/image_layer_dir/b91ed1b448ac52d251c785f5cfc299ca3ba4cfd68d739832b766228afa84a651=ro+wh:~/tca_agent/image_layer_dir/0169cd8bc0bdbecedb30c7d995e69e832d7ccd5c435e72c40af6940db87851b7=ro+wh:~/tca_agent/image_layer_dir/e7ef7d443e31f8b3b8a0a002a6895746d3737289eb2eea18d669924c089279f2=ro+wh:~/tca_agent/image_layer_dir/31bfb0cd724fda09280305b8dc1c4b0587ca01f5dd503d28afa82cff4fa92475=ro+wh:~/tca_agent/image_layer_dir/74428f0d76521fa9b9b1189cb72d303e367003c113cc8a11db125e3f7df1daa1=ro+wh:~/tca_agent/image_layer_dir/b20a927da14045cac0cd6a745f67fdeb88ead6d85752c670ea2773b27387f6ae=ro+wh:~/tca_agent/image_layer_dir/7dee3bce119631e3c922d78860d6b0ae160e237b63bf19f43713a05d1086c72f=ro+wh:~/tca_agent/image_layer_dir/636bce8f18e8734cb98f170bdcf1fb9ae52f1b091bfadcb2bef378b0d829ceb6=ro+wh:~/tca_agent/image_layer_dir/9c6fde234e701cf7b61534ef3a23cc4e0cdb6d3ffc497feaa8fcddc52e8d1fda=ro+wh:~/tca_agent/image_layer_dir/83c2f1968a932e3e284ef20b10a4ef8a9cfc01589dacf2100fb9a78e88c3888e=ro+wh:~/tca_agent/image_layer_dir/ec096a351601040fcd37c31edccd2f68106438097e8adf7253539366b2232de5=ro+wh:~/tca_agent/image_layer_dir/6de889accecb819028355196bde150749598e982b5dfe556540e102c737bfc34=ro+wh:~/tca_agent/image_layer_dir/1042cb8f2263d1030fdb57e0ca671b34a2180bb35d9448737e4a03e4987cf942=ro+wh:~/tca_agent/image_layer_dir/4fab8c997a447af2375e325467661ca1d74bf62dc6d802426f20d0134c9c43bc=ro+wh:~/tca_agent/image_layer_dir/ca57efb1c28464fab46af1826243c02af0a0b6cfb90bf92b30110e79028c5e68=ro+wh:~/tca_agent/image_layer_dir/ad86d54176611b5117fc155e8dfbd0b59bc0abce4e2051baef12c2f1e152c92f=ro+wh:~/tca_agent/image_layer_dir/f323ae7b264dcc517876e7c722ac3369baaef1a7c18cc5aae5f43f440fd646c0=ro+wh:~/tca_agent/image_layer_dir/a7d1c89c8422563102bd353de46154191038f92c9ebde8b22a8b2749140029ec=ro+wh:~/tca_agent/image_layer_dir/104adb8634902678f87db6bdbdb12d43d5bd6db9909ae9b12e078286046a1298=ro+wh:~/tca_agent/image_layer_dir/00450b5308ac99846ae7e5fa47652952c4fbbe82882ac241d5153d630644f790=ro+wh:~/tca_agent/image_layer_dir/129675caf5fdc1616c619d5b5718417806a64f282d324a3a580d6df1269b4f3f=ro+wh:~/tca_agent/image_layer_dir/8ce8b37ab4829a1fd34fcd38842b912d46eb3f7511365ccec0399a06670ab2fc=ro+wh:~/tca_agent/image_layer_dir/57080e2e0baad381605079107f08435133d7829364a9c450fc08877f01e57601=ro+wh:~/tca_agent/image_layer_dir/9ca225075a8c2bfd27ef5084e41335d781d24e7be0cbf4575ec3d42de662c6ac=ro+wh:~/tca_agent/image_layer_dir/74ec3835691908f9e6e271797f373257de3f9cc4bb408fd66dd229537ea5fcc1=ro+wh:~/tca_agent/image_layer_dir/59aa8f04c38abaae9c0e430d7b1a91f6560641e429386ee2c4eec57f0af35c04=ro+wh:~/tca_agent/image_layer_dir/bc318ac48b4f7a9536b72e2b0f223726a5225e13ecc70eba4b7b00e2bf80081b=ro+wh:~/tca_agent/image_layer_dir/bbfb0e8818be82ca0f17f280f7ad89497fef6c92e2bb50c40b2bd17c79347425=ro+wh:~/tca_agent/image_layer_dir/f36b94436263ce21d885d2f3f94c7b307e966a989fcefd3027c039e987d7dc2b=ro+wh:~/tca_agent/image_layer_dir/9103dae307f5748103f89093273329a523300b4f103a1d397c44abd766fe0015=ro+wh:~/tca_agent/image_layer_dir/9bd48cc89c1fc083b0db7ed45e5d7e4fec277450b8b47f96884588930ce8c56f=ro+wh:~/tca_agent/image_layer_dir/47ba0411cc8344ab1895a6b8eb0878a9ffd34410170a140ad1f210f20eedcdce=ro+wh:~/tca_agent/image_layer_dir/42b317de582399eb395b2818b4d658fb0a5987e8df1163e49ac2d8bec95a078e=ro+wh:~/tca_agent/image_layer_dir/57bb07a87ab6c29b048638c65566febe800fe79672730f7bb9e70b8f2e677e5a=ro+wh:~/tca_agent/image_layer_dir/b89b49aa036df19c6a2e77cc4aaef707ab3fd916d2d936b9e5e160d448d96ab3=ro+wh:~/tca_agent/image_layer_dir/d7bf931f8235cc7cc68c223b2945f77e858eb8cff4c9cb8bd64bacfd29312672=ro+wh:~/tca_agent/image_layer_dir/49a8b40dbec97066dbad4fb14d1bf388102190442679527e112b030270426ccc=ro+wh:~/tca_agent/image_layer_dir/05f05d402ea8ee67da1af2c9e35d10b9619b0f0c14a56788a1a0b5eeb290d685=ro+wh:~/tca_agent/image_layer_dir/b05d3f32ac4ff52a542dfcf50dbf155d060d79bd23d0ebed1439a3c6b1120731=ro+wh:~/tca_agent/image_layer_dir/0d061258f32c904c95aa020a9f679790c5722c3017eef98e298d6e29b4f02089=ro+wh:~/tca_agent/image_layer_dir/1f9c07049bcd59c59413c1706d0402b04c96598174eb16ef3de25b4e47413ad2=ro+wh:~/tca_agent/image_layer_dir/a86578a8bff61017b80eb653705c3f41136efb9b88facd6a2c67e8b3426e47f9=ro+wh:~/tca_agent/image_layer_dir/c3fdf4a694f0cc03939ee2cfdd09fb623966c5bb193778eaaea317655773656e=ro+wh:~/tca_agent/image_layer_dir/1b8fcd446a37050b55f57687aaae1150d74cc7f4468bbd00942535bad5ab22fe=ro+wh:~/tca_agent/image_layer_dir/6624cfa732b528cf7c1996719e30d1525aa27af7584f61a149d4d386aa8cf301=ro+wh:~/tca_agent/image_layer_dir/5b57e87f9b5859d902c4338c7a7ce5996a51fb8226a8f11ab29e10af4af5f14f=ro+wh:~/tca_agent/image_layer_dir/0c65112ac5c572a950e2671f903ef11e918e6e3cdbf026edda90db6c7a9c6ef8=ro+wh:~/tca_agent/image_layer_dir/ce16b72d243b82ded684a547da1400b8f2d07ed7b36b114ae0cbe2f20c17b0bf=ro+wh:~/tca_agent/image_layer_dir/a3937b112d7dbedfe075162862e404b7b85803d880589eaf3ebad9855629bdd5=ro+wh:~/tca_agent/image_layer_dir/b486d646cd9f5b8151856133ea3e81d53c3664bb727a0a87d0197cbbae9211de=ro+wh:~/tca_agent/image_layer_dir/de1b712fcfedbc3f61248c1a5fb9cba5a5ab6c7415f2c71c7ea162fd7c738c6f=ro+wh:~/tca_agent/image_layer_dir/2958a858559d3091b8162c066cfe5e17012f2307772180e702ffbc89bcae8fc2=ro+wh:~/tca_agent/image_layer_dir/14eae848ef41eb275ad37cc9d12dc276d3f08beeb06e041407371b9489335ee1=ro+wh:~/tca_agent/image_layer_dir/d72e07c403501a4abefaa80f3b81121392c42f314fc14bbf1bb434dc84457dd5=ro+wh:~/tca_agent/image_layer_dir/ee0efde24e35b4e2f801ca25640169ca2f319f9b5d37dbb0917cfd43e818d1f4=ro+wh:~/tca_agent/image_layer_dir/67dfb4d7c7ce39829d36740e1ef5279e00320a0d2bfe06bb67b6571f1ff47627=ro+wh:~/tca_agent/image_layer_dir/b3a1a69310f719755232ed5f8509f11f549d620d723ea293f001e3d30795108b=ro+wh:~/tca_agent/image_layer_dir/a3ed95caeb02ffe68cdd9fd84406680ae93d633cb16422d00e8a7c22955b46d4=ro+wh:~/tca_agent/image_layer_dir/e5ad7970bc69d2ba62d2bbb4b80627273350e1982ff43bc1ca04a3215bc6da5b=ro+wh none ~/tca_agent/container_root_dir/51509032
> > dmesg : [343090.744067] aufs opt_add:810:mount[30864]: lookup failed /root/tca_agent/image_layer_di (-2)

I think kernel at least must print warning message when mount option 
overflow the PAGE_SIZE if length of mount option should be fixed. 
When i encouter this problem, i found the reason hard because of 
lack of kernel log and wrong infomation.

> > ------------------------------------------------------------------------
> > 
> > br option is cut and aufs search cut directory. Length of mount option
> > is about 6400.
> 
> The lack of planning on your part...
> 
> IOW, don't do it.  Use of symlinks (or bindings) might alleviate the problem
> if aufs interface is that nasty.  And before you go "just read up to \0",
> consider e.g. NFS flavours with binary data structure passed instead of
> a string.

Do you mean using symlinks or bind mount to reduce length of mount
options?? I can remove "~/tca_agent/image_layer_dir" string. But the
other character means unique ID of layer and i can't compress it or
replace it to another string. This is not fundamental solution. Docker 
use the same unique ID to manage layers. 

As i said before overlayfs could suffer same problem because overlayfs 
support multiple lowerdir options and there is no route to pass lower
dirs without mount option. So i think to support unionfs stably in
kernel, dynamic memory allocation for mount option is needed.

Thanks.
