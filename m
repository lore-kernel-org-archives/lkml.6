Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619FBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE31D20894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WKmQCXC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE31D20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeH1UTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:19:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35424 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeH1UTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:19:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7SGIWRs125014;
        Tue, 28 Aug 2018 16:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=0iUgnKOiptQDk5Y4nOHtGhrKSeEGvTmau9jPQOdmrX0=;
 b=WKmQCXC/ccd3iINK5cNaDJzxwDX6dOxWbXJCq6o1yIDmxZht353Bf6y6PczG69zAbPT+
 4DU2+4x06R2ZDCvMHQcqgPYO4qW/MAAzFW+gxj259qRUzGsPuH7cYiKYg7Mf/mllrQwW
 86Ob9IOFghaZzrjVurkr4/32FHmXEtM5Y9XKTRu5FCIyKWxmOoi/ueipyrcLDt49NI3N
 Ab28of0XirGtE+fm1Sv9EXJTPFL1LX1+VKkpTquLWArkY4rtIZXh043x0muwxOqRJY/D
 ht1/fgj+cGlTjoNvGPLdZIymt0LCqTEFp11peemLwCQCN7W2QxF4yGVdwZp/RKuDTshg sQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2m2yrq4x55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 16:26:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7SGQLJe011978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 16:26:22 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7SGQLgP023704;
        Tue, 28 Aug 2018 16:26:21 GMT
Received: from [10.175.183.179] (/10.175.183.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Aug 2018 09:26:21 -0700
Subject: Re: [PATCH v2] objtool: Support multiple rodata sections.
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20180803184040.15372-1-allan.x.xavier@oracle.com>
From:   Allan Xavier <allan.x.xavier@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=allan.x.xavier@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jycc5aNW5OOSmgYj
Message-ID: <e69e1706-c226-deb2-2a49-15030599a8e8@oracle.com>
Date:   Tue, 28 Aug 2018 17:26:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803184040.15372-1-allan.x.xavier@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8998 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808280165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping... are there any comments on this?

On 03/08/18 19:40, Allan Xavier wrote:
> This commit adds support for processing switch jump tables in objects
> with multiple .rodata sections, such as those created when using
> -ffunction-sections and -fdata-sections.  Currently, objtool always
> looks in .rodata for jump table information which results in many
> "sibling call from callable instruction with modified stack frame"
> warnings with objects compiled using those flags.
> 
> The fix is comprised of three parts:
> 
> 1. Flagging all .rodata sections when importing elf information for
> easier checking later.
> 
> 2. Keeping a reference to the section each relocation is from in order
> to get the list_head for the other relocations in that section.
> 
> 3. Finding jump tables by following relocations to .rodata sections,
> rather than always referencing a single global .rodata section.
> 
> The patch has been tested without data sections enabled and no
> differences in the resulting orc unwind information were seen.
> 
> Note that as objtool adds terminators to end of each .text section the
> unwind information generated between a function+data sections build and
> a normal build aren't directly comparable. Manual inspection suggests
> that objtool is now generating the correct information, or at least
> making more of an effort to do so than it did previously.
> 
> Signed-off-by: Allan Xavier <allan.x.xavier@oracle.com>
> ---
> Changes since v1:
>  - Cleaned up section symbol check.
>  - Fixed brackets.
>  - Moved mark_rodata to decode_sections().
>  - Excluded *.str1.[18] sections from rodata sections.
> 
>  tools/objtool/check.c | 39 +++++++++++++++++++++++++++++++++------
>  tools/objtool/check.h |  4 ++--
>  tools/objtool/elf.c   |  1 +
>  tools/objtool/elf.h   |  3 ++-
>  4 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index f4a25bd1871fb..e3a5d53c4b83b 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -836,7 +836,7 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
>  	struct symbol *pfunc = insn->func->pfunc;
>  	unsigned int prev_offset = 0;
>  
> -	list_for_each_entry_from(rela, &file->rodata->rela->rela_list, list) {
> +	list_for_each_entry_from(rela, &table->rela_sec->rela_list, list) {
>  		if (rela == next_table)
>  			break;
>  
> @@ -926,6 +926,7 @@ static struct rela *find_switch_table(struct objtool_file *file,
>  {
>  	struct rela *text_rela, *rodata_rela;
>  	struct instruction *orig_insn = insn;
> +	struct section *rodata_sec;
>  	unsigned long table_offset;
>  
>  	/*
> @@ -953,10 +954,13 @@ static struct rela *find_switch_table(struct objtool_file *file,
>  		/* look for a relocation which references .rodata */
>  		text_rela = find_rela_by_dest_range(insn->sec, insn->offset,
>  						    insn->len);
> -		if (!text_rela || text_rela->sym != file->rodata->sym)
> +		if (!text_rela || text_rela->sym->type != STT_SECTION ||
> +		    !text_rela->sym->sec->rodata)
>  			continue;
>  
>  		table_offset = text_rela->addend;
> +		rodata_sec = text_rela->sym->sec;
> +
>  		if (text_rela->type == R_X86_64_PC32)
>  			table_offset += 4;
>  
> @@ -964,10 +968,10 @@ static struct rela *find_switch_table(struct objtool_file *file,
>  		 * Make sure the .rodata address isn't associated with a
>  		 * symbol.  gcc jump tables are anonymous data.
>  		 */
> -		if (find_symbol_containing(file->rodata, table_offset))
> +		if (find_symbol_containing(rodata_sec, table_offset))
>  			continue;
>  
> -		rodata_rela = find_rela_by_dest(file->rodata, table_offset);
> +		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
>  		if (rodata_rela) {
>  			/*
>  			 * Use of RIP-relative switch jumps is quite rare, and
> @@ -1052,7 +1056,7 @@ static int add_switch_table_alts(struct objtool_file *file)
>  	struct symbol *func;
>  	int ret;
>  
> -	if (!file->rodata || !file->rodata->rela)
> +	if (!file->rodata)
>  		return 0;
>  
>  	for_each_sec(file, sec) {
> @@ -1197,10 +1201,34 @@ static int read_retpoline_hints(struct objtool_file *file)
>  	return 0;
>  }
>  
> +static void mark_rodata(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	bool found = false;
> +	static const char *str1 = ".str1.";
> +	const int str1len = strlen(str1) + 1;
> +
> +	for_each_sec(file, sec) {
> +		if (strstr(sec->name, ".rodata") == sec->name) {
> +			char *str1pos = sec->name + strlen(sec->name) - str1len;
> +
> +			/* Skips over .rodata.str1.1 and .rodata.str.1.8 */
> +			if (strstr(sec->name, str1) != str1pos) {
> +				sec->rodata = true;
> +				found = true;
> +			}
> +		}
> +	}
> +
> +	file->rodata = found;
> +}
> +
>  static int decode_sections(struct objtool_file *file)
>  {
>  	int ret;
>  
> +	mark_rodata(file);
> +
>  	ret = decode_instructions(file);
>  	if (ret)
>  		return ret;
> @@ -2170,7 +2198,6 @@ int check(const char *_objname, bool orc)
>  	INIT_LIST_HEAD(&file.insn_list);
>  	hash_init(file.insn_hash);
>  	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
> -	file.rodata = find_section_by_name(file.elf, ".rodata");
>  	file.c_file = find_section_by_name(file.elf, ".comment");
>  	file.ignore_unreachables = no_unreachable;
>  	file.hints = false;
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index c6b68fcb926ff..a039521b67530 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -60,8 +60,8 @@ struct objtool_file {
>  	struct elf *elf;
>  	struct list_head insn_list;
>  	DECLARE_HASHTABLE(insn_hash, 16);
> -	struct section *rodata, *whitelist;
> -	bool ignore_unreachables, c_file, hints;
> +	struct section *whitelist;
> +	bool ignore_unreachables, c_file, hints, rodata;
>  };
>  
>  int check(const char *objname, bool orc);
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 7ec85d567598c..f7082de1ee829 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -379,6 +379,7 @@ static int read_relas(struct elf *elf)
>  			rela->offset = rela->rela.r_offset;
>  			symndx = GELF_R_SYM(rela->rela.r_info);
>  			rela->sym = find_symbol_by_index(elf, symndx);
> +			rela->rela_sec = sec;
>  			if (!rela->sym) {
>  				WARN("can't find rela entry symbol %d for %s",
>  				     symndx, sec->name);
> diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
> index de5cd2ddded98..bc97ed86b9cd8 100644
> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -48,7 +48,7 @@ struct section {
>  	char *name;
>  	int idx;
>  	unsigned int len;
> -	bool changed, text;
> +	bool changed, text, rodata;
>  };
>  
>  struct symbol {
> @@ -68,6 +68,7 @@ struct rela {
>  	struct list_head list;
>  	struct hlist_node hash;
>  	GElf_Rela rela;
> +	struct section *rela_sec;
>  	struct symbol *sym;
>  	unsigned int type;
>  	unsigned long offset;
> 
