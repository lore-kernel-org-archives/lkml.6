Return-Path: <changcheng.liu@intel.com>
X-Google-Smtp-Source: AH8x227gkHy3QaZ6tckftFfdlEoRMQMZTcpOlzQmg1sGiTMt3HQyIhqs5w8+tmKD1Y2FBfBb3+m9
ARC-Seal: i=1; a=rsa-sha256; t=1517726867; cv=none;
        d=google.com; s=arc-20160816;
        b=X1U2eFBkacw3Bs6Qi/A1dTAiUuv3LLvnHzZ9Cur6yR2ivlWHdfdu/LqykY//zlT4z4
         iDNyUbfIQHQ1kA6pjVFQWOI4U38djQ5eBNNCSpEQkadc+cGQCf1jeN2GMsOM9sXa9Td5
         dk31EKwzar+CJuvGW0BCufDLVRnhBPG35J8YgKdwKZ8+qOu82GtYwR11dVNY6602vvAr
         xTuZok7QKPDUIH9wYiMsHg/54X6p6+HqgzKTeuMU/H4z6wcmEDesp5c0u2e01pdFrlv7
         UwMiUgaxSYinone7z59tZ2mscZAs8cnbLAiv6Fo8Pe7vhU9utW8n6FqcIrg3inak87Cv
         QmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=xfahsofHCWXbwaM3ycvzRUj4Vkx0PeiFUrf2C+t5E6M=;
        b=i6RN84azLUd8g6a4BG5L3TuUwMpUEVw0JQAM8O7SQD1KN0yiOnYsMe06sESGwJwDcP
         saaTfxqaW1/eXGhCf6xORQ06F3Py+Z0AI7ALKz/y+5JCrSA9KmOOYAfZSD6/c+U0wMBB
         CHrEV8ITyZLpVZCC/QIdbdDcqZdHHlxfU+YjiZxLK3kJKp5q6pxZyt2HsuiNMdQhahJa
         BYm/cFIIIWSVKgRSqPoopjuIYMzFUCGsf8QVKGygyKj7rBi+f3pTwCn0FdUfCuofth7H
         K0ZOXmX5KTD6kVp+I6zPRAm0ylBg6X+x5nH2fDVye1gxI0BD/scNJIEPHBe7mMVZK10b
         +BWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of changcheng.liu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=changcheng.liu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of changcheng.liu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=changcheng.liu@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,458,1511856000";
   d="scan'208,217";a="24541414"
Date: Sun, 4 Feb 2018 14:46:58 +0800
From: "Liu, Changcheng" <changcheng.liu@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kstewart@linuxfoundation.org, neilb@suse.com,
	tglx@linutronix.de, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, alexander.levin@verizon.com
Subject: Re: [PATCH 4.14 103/156] scripts/faddr2line: extend usage on generic
 arch
Message-ID: <20180204064658.GA12094@sofia>
References: <20180202140840.242829545@linuxfoundation.org>
 <20180202140844.857269882@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202140844.857269882@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591310121162171175?=
X-GMAIL-MSGID: =?utf-8?q?1591451968796934177?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg Kroah-Hartman,
    Below commit is needed to resolve issue in this patch:
        Upstream commit 4cc90b4cc3d4955f79eae4f7f9d64e67e17b468e

B.R.
Changcheng

On 17:58 Fri 02 Feb, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: "Liu, Changcheng" <changcheng.liu@intel.com>
> 
> 
> [ Upstream commit 95a87982541932503d3f59aba4c30b0bde0a6294 ]
> 
> When cross-compiling, fadd2line should use the binary tool used for the
> target system, rather than that of the host.
> 
> Link: http://lkml.kernel.org/r/20171121092911.GA150711@sofia
> Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: NeilBrown <neilb@suse.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  scripts/faddr2line |   21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -44,9 +44,16 @@
>  set -o errexit
>  set -o nounset
>  
> +READELF="${CROSS_COMPILE}readelf"
> +ADDR2LINE="${CROSS_COMPILE}addr2line"
> +SIZE="${CROSS_COMPILE}size"
> +NM="${CROSS_COMPILE}nm"
> +
>  command -v awk >/dev/null 2>&1 || die "awk isn't installed"
> -command -v readelf >/dev/null 2>&1 || die "readelf isn't installed"
> -command -v addr2line >/dev/null 2>&1 || die "addr2line isn't installed"
> +command -v ${READELF} >/dev/null 2>&1 || die "readelf isn't installed"
> +command -v ${ADDR2LINE} >/dev/null 2>&1 || die "addr2line isn't installed"
> +command -v ${SIZE} >/dev/null 2>&1 || die "size isn't installed"
> +command -v ${NM} >/dev/null 2>&1 || die "nm isn't installed"
>  
>  usage() {
>  	echo "usage: faddr2line <object file> <func+offset> <func+offset>..." >&2
> @@ -69,10 +76,10 @@ die() {
>  find_dir_prefix() {
>  	local objfile=$1
>  
> -	local start_kernel_addr=$(readelf -sW $objfile | awk '$8 == "start_kernel" {printf "0x%s", $2}')
> +	local start_kernel_addr=$(${READELF} -sW $objfile | awk '$8 == "start_kernel" {printf "0x%s", $2}')
>  	[[ -z $start_kernel_addr ]] && return
>  
> -	local file_line=$(addr2line -e $objfile $start_kernel_addr)
> +	local file_line=$(${ADDR2LINE} -e $objfile $start_kernel_addr)
>  	[[ -z $file_line ]] && return
>  
>  	local prefix=${file_line%init/main.c:*}
> @@ -104,7 +111,7 @@ __faddr2line() {
>  
>  	# Go through each of the object's symbols which match the func name.
>  	# In rare cases there might be duplicates.
> -	file_end=$(size -Ax $objfile | awk '$1 == ".text" {print $2}')
> +	file_end=$(${SIZE} -Ax $objfile | awk '$1 == ".text" {print $2}')
>  	while read symbol; do
>  		local fields=($symbol)
>  		local sym_base=0x${fields[0]}
> @@ -156,10 +163,10 @@ __faddr2line() {
>  
>  		# pass real address to addr2line
>  		echo "$func+$offset/$sym_size:"
> -		addr2line -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;"
> +		${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;"
>  		DONE=1
>  
> -	done < <(nm -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
> +	done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
>  }
>  
>  [[ $# -lt 2 ]] && usage
> 
> 
