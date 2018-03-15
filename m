Date: Thu, 15 Mar 2018 18:34:14 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	ARM <linux-arm-kernel@lists.infradead.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Patrice Chotard <patrice.chotard@st.com>,
	Rob Herring <robh@kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the arm-soc tree
Message-ID: <20180315173414.GB29986@kroah.com>
References: <20180315172858.7928ed93@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315172858.7928ed93@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 05:28:58PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the tty tree got conflicts in:
> 
>   arch/arm/boot/dts/stih407-b2120.dts
>   arch/arm/boot/dts/stih410-b2120.dts
>   arch/arm/boot/dts/stih410-b2260.dts
>   arch/arm/boot/dts/stih418-b2199.dts
> 
> between commit:
> 
>   db5430663017 ("arm: dts: replace 'linux,stdout-path' with 'stdout-path'")
> 
> from the arm-soc tree and commit:
> 
>   dbb3fb45edff ("ARM: dts: STi: Remove "console=ttyASN" from bootargs for STi boards")
> 
> from the tty tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/arm/boot/dts/stih407-b2120.dts
> index de3c8bf129b5,a7a0f76e9cbc..000000000000
> --- a/arch/arm/boot/dts/stih407-b2120.dts
> +++ b/arch/arm/boot/dts/stih407-b2120.dts
> @@@ -14,11 -14,11 +14,11 @@@
>   	compatible = "st,stih407-b2120", "st,stih407";
>   
>   	chosen {
> - 		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> + 		bootargs = "clk_ignore_unused";
>  -		linux,stdout-path = &sbc_serial0;
>  +		stdout-path = &sbc_serial0;
>   	};
>   
>  -	memory {
>  +	memory@40000000 {
>   		device_type = "memory";
>   		reg = <0x40000000 0x80000000>;
>   	};
> diff --cc arch/arm/boot/dts/stih410-b2120.dts
> index 0a59b7b0f4b2,6c6b4cc37e97..000000000000
> --- a/arch/arm/boot/dts/stih410-b2120.dts
> +++ b/arch/arm/boot/dts/stih410-b2120.dts
> @@@ -14,11 -14,11 +14,11 @@@
>   	compatible = "st,stih410-b2120", "st,stih410";
>   
>   	chosen {
> - 		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> + 		bootargs = "clk_ignore_unused";
>  -		linux,stdout-path = &sbc_serial0;
>  +		stdout-path = &sbc_serial0;
>   	};
>   
>  -	memory {
>  +	memory@40000000 {
>   		device_type = "memory";
>   		reg = <0x40000000 0x80000000>;
>   	};
> diff --cc arch/arm/boot/dts/stih410-b2260.dts
> index feb8834478fa,50d36758391c..000000000000
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@@ -15,11 -15,11 +15,11 @@@
>   	compatible = "st,stih410-b2260", "st,stih410";
>   
>   	chosen {
> - 		bootargs = "console=ttyAS1,115200 clk_ignore_unused";
> + 		bootargs = "clk_ignore_unused";
>  -		linux,stdout-path = &uart1;
>  +		stdout-path = &uart1;
>   	};
>   
>  -	memory {
>  +	memory@40000000 {
>   		device_type = "memory";
>   		reg = <0x40000000 0x40000000>;
>   	};
> diff --cc arch/arm/boot/dts/stih418-b2199.dts
> index 39b4db2e3507,7f5f3252bfc7..000000000000
> --- a/arch/arm/boot/dts/stih418-b2199.dts
> +++ b/arch/arm/boot/dts/stih418-b2199.dts
> @@@ -14,11 -14,11 +14,11 @@@
>   	compatible = "st,stih418-b2199", "st,stih418";
>   
>   	chosen {
> - 		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> + 		bootargs = "clk_ignore_unused";
>  -		linux,stdout-path = &sbc_serial0;
>  +		stdout-path = &sbc_serial0;
>   	};
>   
>  -	memory {
>  +	memory@40000000 {
>   		device_type = "memory";
>   		reg = <0x40000000 0xc0000000>;
>   	};


Ugh, messy, thanks for the merge fixup.

greg k-h
