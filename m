Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965921AbeCAEf3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 23:35:29 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:58286 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965813AbeCAEfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 23:35:25 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w214ZJ3g014025
X-Nifty-SrcIP: [209.85.217.170]
X-Google-Smtp-Source: AG47ELueh6VHO74CmoNVNbZ/AA5RdQ/GmngMDA5ARJO5x4y8OXKb7Lc0hyTIVMiRIwbsk2pxLYFRyugZ+StZfPxona0=
MIME-Version: 1.0
In-Reply-To: <20180228233249.26281-5-robh@kernel.org>
References: <20180228233249.26281-1-robh@kernel.org> <20180228233249.26281-5-robh@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Mar 2018 13:34:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATiM0o4KX1Lt+cP6APVzTMVN195yiuUiD9Ny5roZgrK1g@mail.gmail.com>
Message-ID: <CAK7LNATiM0o4KX1Lt+cP6APVzTMVN195yiuUiD9Ny5roZgrK1g@mail.gmail.com>
Subject: Re: [PATCH 4/6] scripts/dtc: generate lexer and parser during build
 instead of shipping
To: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-01 8:32 GMT+09:00 Rob Herring <robh@kernel.org>:
> Now that the kernel build supports flex and bison, remove the _shipped
> files and generate them during the build instead.
>
> Based on Masahiro's original patch.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  scripts/dtc/Makefile                 |    6 +-
>  scripts/dtc/dtc-lexer.lex.c_shipped  | 2259 ---------------------------------
>  scripts/dtc/dtc-parser.tab.c_shipped | 2321 ----------------------------------
>  scripts/dtc/dtc-parser.tab.h_shipped |  125 --
>  scripts/dtc/update-dtc-source.sh     |    5 -




As you know, this introduces
scripts/dtc/dtc-parser.y: warning: 3 shift/reduce conflicts [-Wconflicts-sr]
then, the next commit will fix it.

I do not have a strong opinion about the parch order.
It would be ridiculous to update *_shipped
that will be immediately removed.  So, probably this is OK.



FWIW.

This is completely out of realm of my field since
I speak Japanese in my daily life.

Is it better to change
the 'singular vs plural' in the comment block?


# This script assumes that the dtc and the linux git trees are in the
# same directory. After building dtc in the dtc directory, it copies the
# source files and generated source files into the scripts/dtc directory
# in the kernel and creates a git commit updating them to the new
# version.


After this commit, 'version_gen.h' will be the only generated file.
"generated source files" sounds like we have more.


Please take it FWIW.
I am just nit-picking
according to what I learned at junior high school, which might be wrong.



Otherwise,

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


>  5 files changed, 4 insertions(+), 4712 deletions(-)
>  delete mode 100644 scripts/dtc/dtc-lexer.lex.c_shipped
>  delete mode 100644 scripts/dtc/dtc-parser.tab.c_shipped
>  delete mode 100644 scripts/dtc/dtc-parser.tab.h_shipped
>
> -#define YY_DO_BEFORE_ACTION \
> -       (yytext_ptr) = yy_bp; \
> -       yyleng = (int) (yy_cp - yy_bp); \
> -       (yy_hold_char) = *yy_cp; \
> -       *yy_cp = '\0'; \
> -       (yy_c_buf_p) = yy_cp;
> -
> -#define YY_NUM_RULES 31
> -#define YY_END_OF_BUFFER 32
> -/* This struct is not used in this scanner,
> -   but its presence is necessary. */
> -struct yy_trans_info
> -       {
> -       flex_int32_t yy_verify;
> -       flex_int32_t yy_nxt;
> -       };
> -static yyconst flex_int16_t yy_accept[166] =
> -    {   0,
> -        0,    0,    0,    0,    0,    0,    0,    0,   32,   30,
> -       19,   19,   30,   30,   30,   30,   30,   30,   30,   30,
> -       30,   30,   30,   30,   30,   30,   16,   17,   17,   30,
> -       17,   11,   11,   19,   27,    0,    3,    0,   28,   13,
> -        0,    0,   12,    0,    0,    0,    0,    0,    0,    0,
> -        0,   22,   24,   26,   25,   23,    0,   10,   29,    0,
> -        0,    0,   15,   15,   17,   17,   17,   11,   11,   11,
> -        0,   13,    0,   12,    0,    0,    0,   21,    0,    0,
> -        0,    0,    0,    0,    0,    0,    0,   17,   11,   11,
> -       11,    0,   14,   20,    0,    0,    0,    0,    0,    0,
> -
> -        0,    0,    0,    0,   17,    0,    0,    0,    0,    0,
> -        0,    0,    0,    0,    0,   17,    7,    0,    0,    0,
> -        0,    0,    0,    0,    2,    0,    0,    0,    0,    0,
> -        0,    0,    0,    0,    4,   18,    0,    0,    5,    2,
> -        0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
> -        0,    0,    1,    0,    0,    0,    0,    6,    9,    0,
> -        0,    0,    0,    8,    0
> -    } ;
> -
> -static yyconst YY_CHAR yy_ec[256] =
> -    {   0,
> -        1,    1,    1,    1,    1,    1,    1,    1,    2,    3,
> -        4,    4,    4,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    2,    5,    6,    7,    1,    1,    8,    9,    1,
> -        1,   10,   11,   11,   12,   11,   13,   14,   15,   16,
> -       16,   16,   16,   16,   16,   16,   16,   17,    1,   18,
> -       19,   20,   11,   11,   21,   21,   21,   21,   21,   21,
> -       22,   22,   22,   22,   22,   23,   22,   22,   22,   22,
> -       22,   22,   22,   22,   24,   22,   22,   25,   22,   22,
> -        1,   26,   27,    1,   22,    1,   21,   28,   29,   30,
> -
> -       31,   21,   32,   22,   33,   22,   22,   34,   35,   36,
> -       37,   38,   22,   39,   40,   41,   42,   43,   22,   25,
> -       44,   22,   45,   46,   47,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1
> -    } ;
> -
> -static yyconst YY_CHAR yy_meta[48] =
> -    {   0,
> -        1,    1,    1,    1,    1,    1,    2,    3,    1,    2,
> -        2,    2,    4,    5,    5,    5,    6,    1,    1,    1,
> -        7,    8,    8,    8,    8,    1,    1,    7,    7,    7,
> -        7,    8,    8,    8,    8,    8,    8,    8,    8,    8,
> -        8,    8,    8,    8,    3,    1,    4
> -    } ;
> -
> -static yyconst flex_uint16_t yy_base[180] =
> -    {   0,
> -        0,  393,   35,  392,   66,  391,   38,  107,  397,  401,
> -       55,  113,  377,  112,  111,  111,  114,   42,  376,  106,
> -      377,  347,  126,  120,    0,  147,  401,    0,  124,    0,
> -      137,  158,  170,  163,  401,  153,  401,  389,  401,    0,
> -      378,  120,  401,  131,  380,  386,  355,  139,  351,  355,
> -      351,  401,  401,  401,  401,  401,  367,  401,  401,  185,
> -      350,  346,  401,  364,    0,  185,  347,  189,  356,  355,
> -        0,    0,  330,  180,  366,  141,  372,  361,  332,  338,
> -      331,  341,  334,  326,  205,  331,  337,  329,  401,  341,
> -      167,  316,  401,  349,  348,  320,  328,  346,  180,  318,
> -
> -      324,  209,  324,  320,  322,  342,  338,  309,  306,  315,
> -      305,  315,  312,  192,  342,  341,  401,  293,  306,  282,
> -      268,  252,  255,  203,  285,  282,  272,  268,  252,  233,
> -      232,  239,  208,  107,  401,  401,  238,  211,  401,  211,
> -      212,  208,  228,  203,  215,  207,  233,  222,  212,  211,
> -      203,  227,  401,  237,  225,  204,  185,  401,  401,  149,
> -      128,   88,   42,  401,  401,  253,  259,  267,  271,  275,
> -      281,  288,  292,  300,  308,  312,  318,  326,  334
> -    } ;
> -
> -static yyconst flex_int16_t yy_def[180] =
> -    {   0,
> -      165,    1,    1,    3,  165,    5,    1,    1,  165,  165,
> -      165,  165,  165,  166,  167,  168,  165,  165,  165,  165,
> -      169,  165,  165,  165,  170,  169,  165,  171,  172,  171,
> -      171,  165,  165,  165,  165,  166,  165,  166,  165,  173,
> -      165,  168,  165,  168,  174,  175,  165,  165,  165,  165,
> -      165,  165,  165,  165,  165,  165,  169,  165,  165,  165,
> -      165,  165,  165,  169,  171,  172,  171,  165,  165,  165,
> -      176,  173,  177,  168,  174,  174,  175,  165,  165,  165,
> -      165,  165,  165,  165,  165,  165,  165,  171,  165,  165,
> -      176,  177,  165,  165,  165,  165,  165,  165,  165,  165,
> -
> -      165,  165,  165,  165,  171,  165,  165,  165,  165,  165,
> -      165,  165,  165,  178,  165,  171,  165,  165,  165,  165,
> -      165,  165,  165,  178,  165,  178,  165,  165,  165,  165,
> -      165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
> -      165,  165,  165,  165,  165,  165,  165,  179,  165,  165,
> -      165,  179,  165,  179,  165,  165,  165,  165,  165,  165,
> -      165,  165,  165,  165,    0,  165,  165,  165,  165,  165,
> -      165,  165,  165,  165,  165,  165,  165,  165,  165
> -    } ;
> -
> -static yyconst flex_uint16_t yy_nxt[449] =
> -    {   0,
> -       10,   11,   12,   11,   13,   14,   10,   15,   16,   10,
> -       10,   10,   17,   10,   10,   10,   10,   18,   19,   20,
> -       21,   21,   21,   21,   21,   10,   10,   21,   21,   21,
> -       21,   21,   21,   21,   21,   21,   21,   21,   21,   21,
> -       21,   21,   21,   21,   10,   22,   10,   24,   25,   25,
> -       25,   32,   33,   33,  164,   26,   34,   34,   34,   52,
> -       53,   27,   26,   26,   26,   26,   10,   11,   12,   11,
> -       13,   14,   28,   15,   16,   28,   28,   28,   24,   28,
> -       28,   28,   10,   18,   19,   20,   29,   29,   29,   29,
> -       29,   30,   10,   29,   29,   29,   29,   29,   29,   29,
> -
> -       29,   29,   29,   29,   29,   29,   29,   29,   29,   29,
> -       10,   22,   10,   23,   34,   34,   34,   37,   39,   43,
> -       32,   33,   33,   45,   55,   56,   46,   60,   43,   45,
> -       65,  163,   46,   65,   65,   65,   44,   38,   60,   74,
> -       58,   47,  141,   48,  142,   44,   49,   47,   50,   48,
> -       76,   51,   62,   94,   50,   41,   44,   51,   37,   61,
> -       64,   64,   64,   58,   34,   34,   34,   64,  162,   80,
> -       67,   68,   68,   68,   64,   64,   64,   64,   38,   81,
> -       69,   70,   71,   68,   68,   68,   60,  161,   43,   69,
> -       70,   65,   69,   70,   65,   65,   65,  125,   85,   85,
> -
> -       85,   58,   68,   68,   68,   44,  102,  110,  125,  133,
> -      102,   69,   70,  111,  114,  160,  159,  126,   85,   85,
> -       85,  140,  140,  140,  140,  140,  140,  153,  126,  147,
> -      147,  147,  153,  148,  147,  147,  147,  158,  148,  165,
> -      157,  156,  155,  151,  150,  149,  146,  154,  145,  144,
> -      143,  139,  154,   36,   36,   36,   36,   36,   36,   36,
> -       36,   40,  138,  137,  136,   40,   40,   42,   42,   42,
> -       42,   42,   42,   42,   42,   57,   57,   57,   57,   63,
> -      135,   63,   65,  134,  165,   65,  133,   65,   65,   66,
> -      132,  131,   66,   66,   66,   66,   72,  130,   72,   72,
> -
> -       75,   75,   75,   75,   75,   75,   75,   75,   77,   77,
> -       77,   77,   77,   77,   77,   77,   91,  129,   91,   92,
> -      128,   92,   92,  127,   92,   92,  124,  124,  124,  124,
> -      124,  124,  124,  124,  152,  152,  152,  152,  152,  152,
> -      152,  152,   60,   60,  123,  122,  121,  120,  119,  118,
> -      117,   45,  116,  111,  115,  113,  112,  109,  108,  107,
> -       46,  106,   93,   89,  105,  104,  103,  101,  100,   99,
> -       98,   97,   96,   95,   78,   76,   93,   90,   89,   88,
> -       58,   87,   86,   58,   84,   83,   82,   79,   78,   76,
> -       73,  165,   59,   58,   54,   35,  165,   31,   23,   23,
> -
> -        9,  165,  165,  165,  165,  165,  165,  165,  165,  165,
> -      165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
> -      165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
> -      165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
> -      165,  165,  165,  165,  165,  165,  165,  165
> -    } ;
> -
> -static yyconst flex_int16_t yy_chk[449] =
> -    {   0,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    3,    3,    3,
> -        3,    7,    7,    7,  163,    3,   11,   11,   11,   18,
> -       18,    3,    3,    3,    3,    3,    5,    5,    5,    5,
> -        5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
> -        5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
> -        5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
> -
> -        5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
> -        5,    5,    5,    8,   12,   12,   12,   14,   15,   16,
> -        8,    8,    8,   17,   20,   20,   17,   23,   42,   24,
> -       29,  162,   24,   29,   29,   29,   16,   14,   31,   44,
> -       29,   17,  134,   17,  134,   42,   17,   24,   17,   24,
> -       76,   17,   24,   76,   24,   15,   44,   24,   36,   23,
> -       26,   26,   26,   26,   34,   34,   34,   26,  161,   48,
> -       31,   32,   32,   32,   26,   26,   26,   26,   36,   48,
> -       32,   32,   32,   33,   33,   33,   60,  160,   74,   91,
> -       91,   66,   33,   33,   66,   66,   66,  114,   60,   60,
> -
> -       60,   66,   68,   68,   68,   74,   85,   99,  124,  133,
> -      102,   68,   68,   99,  102,  157,  156,  114,   85,   85,
> -       85,  133,  133,  133,  140,  140,  140,  148,  124,  143,
> -      143,  143,  152,  143,  147,  147,  147,  155,  147,  154,
> -      151,  150,  149,  146,  145,  144,  142,  148,  141,  138,
> -      137,  132,  152,  166,  166,  166,  166,  166,  166,  166,
> -      166,  167,  131,  130,  129,  167,  167,  168,  168,  168,
> -      168,  168,  168,  168,  168,  169,  169,  169,  169,  170,
> -      128,  170,  171,  127,  126,  171,  125,  171,  171,  172,
> -      123,  122,  172,  172,  172,  172,  173,  121,  173,  173,
> -
> -      174,  174,  174,  174,  174,  174,  174,  174,  175,  175,
> -      175,  175,  175,  175,  175,  175,  176,  120,  176,  177,
> -      119,  177,  177,  118,  177,  177,  178,  178,  178,  178,
> -      178,  178,  178,  178,  179,  179,  179,  179,  179,  179,
> -      179,  179,  116,  115,  113,  112,  111,  110,  109,  108,
> -      107,  106,  105,  104,  103,  101,  100,   98,   97,   96,
> -       95,   94,   92,   90,   88,   87,   86,   84,   83,   82,
> -       81,   80,   79,   78,   77,   75,   73,   70,   69,   67,
> -       64,   62,   61,   57,   51,   50,   49,   47,   46,   45,
> -       41,   38,   22,   21,   19,   13,    9,    6,    4,    2,
> -
> -      165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
> -      165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
> -      165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
> -      165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
> -      165,  165,  165,  165,  165,  165,  165,  165
> -    } ;
> -
> -static yy_state_type yy_last_accepting_state;
> -static char *yy_last_accepting_cpos;
> -
> -extern int yy_flex_debug;
> -int yy_flex_debug = 0;
> -
> -/* The intent behind this definition is that it'll catch
> - * any uses of REJECT which flex missed.
> - */
> -#define REJECT reject_used_but_not_detected
> -#define yymore() yymore_used_but_not_detected
> -#define YY_MORE_ADJ 0
> -#define YY_RESTORE_YY_MORE_OFFSET
> -char *yytext;
> -#line 1 "dtc-lexer.l"
> -/*
> - * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
> - *
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of the
> - * License, or (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - *  General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
> - *                                                                   USA
> - */
> -#define YY_NO_INPUT 1
> -
> -
> -
> -#line 37 "dtc-lexer.l"
> -#include "dtc.h"
> -#include "srcpos.h"
> -#include "dtc-parser.tab.h"
> -
> -YYLTYPE yylloc;
> -extern bool treesource_error;
> -
> -/* CAUTION: this will stop working if we ever use yyless() or yyunput() */
> -#define        YY_USER_ACTION \
> -       { \
> -               srcpos_update(&yylloc, yytext, yyleng); \
> -       }
> -
> -/*#define LEXDEBUG     1*/
> -
> -#ifdef LEXDEBUG
> -#define DPRINT(fmt, ...)       fprintf(stderr, fmt, ##__VA_ARGS__)
> -#else
> -#define DPRINT(fmt, ...)       do { } while (0)
> -#endif
> -
> -static int dts_version = 1;
> -
> -#define BEGIN_DEFAULT()                DPRINT("<V1>\n"); \
> -                               BEGIN(V1); \
> -
> -static void push_input_file(const char *filename);
> -static bool pop_input_file(void);
> -static void PRINTF(1, 2) lexical_error(const char *fmt, ...);
> -
> -#line 661 "dtc-lexer.lex.c"
> -
> -#define INITIAL 0
> -#define BYTESTRING 1
> -#define PROPNODENAME 2
> -#define V1 3
> -
> -#ifndef YY_NO_UNISTD_H
> -/* Special case for "unistd.h", since it is non-ANSI. We include it way
> - * down here because we want the user's section 1 to have been scanned first.
> - * The user has a chance to override it with an option.
> - */
> -#include <unistd.h>
> -#endif
> -
> -#ifndef YY_EXTRA_TYPE
> -#define YY_EXTRA_TYPE void *
> -#endif
> -
> -static int yy_init_globals (void );
> -
> -/* Accessor methods to globals.
> -   These are made visible to non-reentrant scanners for convenience. */
> -
> -int yylex_destroy (void );
> -
> -int yyget_debug (void );
> -
> -void yyset_debug (int debug_flag  );
> -
> -YY_EXTRA_TYPE yyget_extra (void );
> -
> -void yyset_extra (YY_EXTRA_TYPE user_defined  );
> -
> -FILE *yyget_in (void );
> -
> -void yyset_in  (FILE * _in_str  );
> -
> -FILE *yyget_out (void );
> -
> -void yyset_out  (FILE * _out_str  );
> -
> -                       int yyget_leng (void );
> -
> -char *yyget_text (void );
> -
> -int yyget_lineno (void );
> -
> -void yyset_lineno (int _line_number  );
> -
> -/* Macros after this point can all be overridden by user definitions in
> - * section 1.
> - */
> -
> -#ifndef YY_SKIP_YYWRAP
> -#ifdef __cplusplus
> -extern "C" int yywrap (void );
> -#else
> -extern int yywrap (void );
> -#endif
> -#endif
> -
> -#ifndef YY_NO_UNPUT
> -
> -#endif
> -
> -#ifndef yytext_ptr
> -static void yy_flex_strncpy (char *,yyconst char *,int );
> -#endif
> -
> -#ifdef YY_NEED_STRLEN
> -static int yy_flex_strlen (yyconst char * );
> -#endif
> -
> -#ifndef YY_NO_INPUT
> -
> -#ifdef __cplusplus
> -static int yyinput (void );
> -#else
> -static int input (void );
> -#endif
> -
> -#endif
> -
> -/* Amount of stuff to slurp up with each read. */
> -#ifndef YY_READ_BUF_SIZE
> -#ifdef __ia64__
> -/* On IA-64, the buffer size is 16k, not 8k */
> -#define YY_READ_BUF_SIZE 16384
> -#else
> -#define YY_READ_BUF_SIZE 8192
> -#endif /* __ia64__ */
> -#endif
> -
> -/* Copy whatever the last rule matched to the standard output. */
> -#ifndef ECHO
> -/* This used to be an fputs(), but since the string might contain NUL's,
> - * we now use fwrite().
> - */
> -#define ECHO do { if (fwrite( yytext, (size_t) yyleng, 1, yyout )) {} } while (0)
> -#endif
> -
> -/* Gets input and stuffs it into "buf".  number of characters read, or YY_NULL,
> - * is returned in "result".
> - */
> -#ifndef YY_INPUT
> -#define YY_INPUT(buf,result,max_size) \
> -       if ( YY_CURRENT_BUFFER_LVALUE->yy_is_interactive ) \
> -               { \
> -               int c = '*'; \
> -               size_t n; \
> -               for ( n = 0; n < max_size && \
> -                            (c = getc( yyin )) != EOF && c != '\n'; ++n ) \
> -                       buf[n] = (char) c; \
> -               if ( c == '\n' ) \
> -                       buf[n++] = (char) c; \
> -               if ( c == EOF && ferror( yyin ) ) \
> -                       YY_FATAL_ERROR( "input in flex scanner failed" ); \
> -               result = n; \
> -               } \
> -       else \
> -               { \
> -               errno=0; \
> -               while ( (result = (int) fread(buf, 1, max_size, yyin))==0 && ferror(yyin)) \
> -                       { \
> -                       if( errno != EINTR) \
> -                               { \
> -                               YY_FATAL_ERROR( "input in flex scanner failed" ); \
> -                               break; \
> -                               } \
> -                       errno=0; \
> -                       clearerr(yyin); \
> -                       } \
> -               }\
> -\
> -
> -#endif
> -
> -/* No semi-colon after return; correct usage is to write "yyterminate();" -
> - * we don't want an extra ';' after the "return" because that will cause
> - * some compilers to complain about unreachable statements.
> - */
> -#ifndef yyterminate
> -#define yyterminate() return YY_NULL
> -#endif
> -
> -/* Number of entries by which start-condition stack grows. */
> -#ifndef YY_START_STACK_INCR
> -#define YY_START_STACK_INCR 25
> -#endif
> -
> -/* Report a fatal error. */
> -#ifndef YY_FATAL_ERROR
> -#define YY_FATAL_ERROR(msg) yy_fatal_error( msg )
> -#endif
> -
> -/* end tables serialization structures and prototypes */
> -
> -/* Default declaration of generated scanner - a define so the user can
> - * easily add parameters.
> - */
> -#ifndef YY_DECL
> -#define YY_DECL_IS_OURS 1
> -
> -extern int yylex (void);
> -
> -#define YY_DECL int yylex (void)
> -#endif /* !YY_DECL */
> -
> -/* Code executed at the beginning of each rule, after yytext and yyleng
> - * have been set up.
> - */
> -#ifndef YY_USER_ACTION
> -#define YY_USER_ACTION
> -#endif
> -
> -/* Code executed at the end of each rule. */
> -#ifndef YY_BREAK
> -#define YY_BREAK /*LINTED*/break;
> -#endif
> -
> -#define YY_RULE_SETUP \
> -       if ( yyleng > 0 ) \
> -               YY_CURRENT_BUFFER_LVALUE->yy_at_bol = \
> -                               (yytext[yyleng - 1] == '\n'); \
> -       YY_USER_ACTION
> -
> -/** The main scanner function which does all the work.
> - */
> -YY_DECL
> -{
> -       yy_state_type yy_current_state;
> -       char *yy_cp, *yy_bp;
> -       int yy_act;
> -
> -       if ( !(yy_init) )
> -               {
> -               (yy_init) = 1;
> -
> -#ifdef YY_USER_INIT
> -               YY_USER_INIT;
> -#endif
> -
> -               if ( ! (yy_start) )
> -                       (yy_start) = 1; /* first start state */
> -
> -               if ( ! yyin )
> -                       yyin = stdin;
> -
> -               if ( ! yyout )
> -                       yyout = stdout;
> -
> -               if ( ! YY_CURRENT_BUFFER ) {
> -                       yyensure_buffer_stack ();
> -                       YY_CURRENT_BUFFER_LVALUE =
> -                               yy_create_buffer(yyin,YY_BUF_SIZE );
> -               }
> -
> -               yy_load_buffer_state( );
> -               }
> -
> -       {
> -#line 69 "dtc-lexer.l"
> -
> -#line 885 "dtc-lexer.lex.c"
> -
> -       while ( /*CONSTCOND*/1 )                /* loops until end-of-file is reached */
> -               {
> -               yy_cp = (yy_c_buf_p);
> -
> -               /* Support of yytext. */
> -               *yy_cp = (yy_hold_char);
> -
> -               /* yy_bp points to the position in yy_ch_buf of the start of
> -                * the current run.
> -                */
> -               yy_bp = yy_cp;
> -
> -               yy_current_state = (yy_start);
> -               yy_current_state += YY_AT_BOL();
> -yy_match:
> -               do
> -                       {
> -                       YY_CHAR yy_c = yy_ec[YY_SC_TO_UI(*yy_cp)] ;
> -                       if ( yy_accept[yy_current_state] )
> -                               {
> -                               (yy_last_accepting_state) = yy_current_state;
> -                               (yy_last_accepting_cpos) = yy_cp;
> -                               }
> -                       while ( yy_chk[yy_base[yy_current_state] + yy_c] != yy_current_state )
> -                               {
> -                               yy_current_state = (int) yy_def[yy_current_state];
> -                               if ( yy_current_state >= 166 )
> -                                       yy_c = yy_meta[(unsigned int) yy_c];
> -                               }
> -                       yy_current_state = yy_nxt[yy_base[yy_current_state] + (flex_int16_t) yy_c];
> -                       ++yy_cp;
> -                       }
> -               while ( yy_current_state != 165 );
> -               yy_cp = (yy_last_accepting_cpos);
> -               yy_current_state = (yy_last_accepting_state);
> -
> -yy_find_action:
> -               yy_act = yy_accept[yy_current_state];
> -
> -               YY_DO_BEFORE_ACTION;
> -
> -do_action:     /* This label is used only to access EOF actions. */
> -
> -               switch ( yy_act )
> -       { /* beginning of action switch */
> -                       case 0: /* must back up */
> -                       /* undo the effects of YY_DO_BEFORE_ACTION */
> -                       *yy_cp = (yy_hold_char);
> -                       yy_cp = (yy_last_accepting_cpos);
> -                       yy_current_state = (yy_last_accepting_state);
> -                       goto yy_find_action;
> -
> -case 1:
> -/* rule 1 can match eol */
> -YY_RULE_SETUP
> -#line 70 "dtc-lexer.l"
> -{
> -                       char *name = strchr(yytext, '\"') + 1;
> -                       yytext[yyleng-1] = '\0';
> -                       push_input_file(name);
> -               }
> -       YY_BREAK
> -case 2:
> -/* rule 2 can match eol */
> -YY_RULE_SETUP
> -#line 76 "dtc-lexer.l"
> -{
> -                       char *line, *fnstart, *fnend;
> -                       struct data fn;
> -                       /* skip text before line # */
> -                       line = yytext;
> -                       while (!isdigit((unsigned char)*line))
> -                               line++;
> -
> -                       /* regexp ensures that first and list "
> -                        * in the whole yytext are those at
> -                        * beginning and end of the filename string */
> -                       fnstart = memchr(yytext, '"', yyleng);
> -                       for (fnend = yytext + yyleng - 1;
> -                            *fnend != '"'; fnend--)
> -                               ;
> -                       assert(fnstart && fnend && (fnend > fnstart));
> -
> -                       fn = data_copy_escape_string(fnstart + 1,
> -                                                    fnend - fnstart - 1);
> -
> -                       /* Don't allow nuls in filenames */
> -                       if (memchr(fn.val, '\0', fn.len - 1))
> -                               lexical_error("nul in line number directive");
> -
> -                       /* -1 since #line is the number of the next line */
> -                       srcpos_set_line(xstrdup(fn.val), atoi(line) - 1);
> -                       data_free(fn);
> -               }
> -       YY_BREAK
> -case YY_STATE_EOF(INITIAL):
> -case YY_STATE_EOF(BYTESTRING):
> -case YY_STATE_EOF(PROPNODENAME):
> -case YY_STATE_EOF(V1):
> -#line 105 "dtc-lexer.l"
> -{
> -                       if (!pop_input_file()) {
> -                               yyterminate();
> -                       }
> -               }
> -       YY_BREAK
> -case 3:
> -/* rule 3 can match eol */
> -YY_RULE_SETUP
> -#line 111 "dtc-lexer.l"
> -{
> -                       DPRINT("String: %s\n", yytext);
> -                       yylval.data = data_copy_escape_string(yytext+1,
> -                                       yyleng-2);
> -                       return DT_STRING;
> -               }
> -       YY_BREAK
> -case 4:
> -YY_RULE_SETUP
> -#line 118 "dtc-lexer.l"
> -{
> -                       DPRINT("Keyword: /dts-v1/\n");
> -                       dts_version = 1;
> -                       BEGIN_DEFAULT();
> -                       return DT_V1;
> -               }
> -       YY_BREAK
> -case 5:
> -YY_RULE_SETUP
> -#line 125 "dtc-lexer.l"
> -{
> -                       DPRINT("Keyword: /plugin/\n");
> -                       return DT_PLUGIN;
> -               }
> -       YY_BREAK
> -case 6:
> -YY_RULE_SETUP
> -#line 130 "dtc-lexer.l"
> -{
> -                       DPRINT("Keyword: /memreserve/\n");
> -                       BEGIN_DEFAULT();
> -                       return DT_MEMRESERVE;
> -               }
> -       YY_BREAK
> -case 7:
> -YY_RULE_SETUP
> -#line 136 "dtc-lexer.l"
> -{
> -                       DPRINT("Keyword: /bits/\n");
> -                       BEGIN_DEFAULT();
> -                       return DT_BITS;
> -               }
> -       YY_BREAK
> -case 8:
> -YY_RULE_SETUP
> -#line 142 "dtc-lexer.l"
> -{
> -                       DPRINT("Keyword: /delete-property/\n");
> -                       DPRINT("<PROPNODENAME>\n");
> -                       BEGIN(PROPNODENAME);
> -                       return DT_DEL_PROP;
> -               }
> -       YY_BREAK
> -case 9:
> -YY_RULE_SETUP
> -#line 149 "dtc-lexer.l"
> -{
> -                       DPRINT("Keyword: /delete-node/\n");
> -                       DPRINT("<PROPNODENAME>\n");
> -                       BEGIN(PROPNODENAME);
> -                       return DT_DEL_NODE;
> -               }
> -       YY_BREAK
> -case 10:
> -YY_RULE_SETUP
> -#line 156 "dtc-lexer.l"
> -{
> -                       DPRINT("Label: %s\n", yytext);
> -                       yylval.labelref = xstrdup(yytext);
> -                       yylval.labelref[yyleng-1] = '\0';
> -                       return DT_LABEL;
> -               }
> -       YY_BREAK
> -case 11:
> -YY_RULE_SETUP
> -#line 163 "dtc-lexer.l"
> -{
> -                       char *e;
> -                       DPRINT("Integer Literal: '%s'\n", yytext);
> -
> -                       errno = 0;
> -                       yylval.integer = strtoull(yytext, &e, 0);
> -
> -                       if (*e && e[strspn(e, "UL")]) {
> -                               lexical_error("Bad integer literal '%s'",
> -                                             yytext);
> -                       }
> -
> -                       if (errno == ERANGE)
> -                               lexical_error("Integer literal '%s' out of range",
> -                                             yytext);
> -                       else
> -                               /* ERANGE is the only strtoull error triggerable
> -                                *  by strings matching the pattern */
> -                               assert(errno == 0);
> -                       return DT_LITERAL;
> -               }
> -       YY_BREAK
> -case 12:
> -/* rule 12 can match eol */
> -YY_RULE_SETUP
> -#line 185 "dtc-lexer.l"
> -{
> -                       struct data d;
> -                       DPRINT("Character literal: %s\n", yytext);
> -
> -                       d = data_copy_escape_string(yytext+1, yyleng-2);
> -                       if (d.len == 1) {
> -                               lexical_error("Empty character literal");
> -                               yylval.integer = 0;
> -                       } else {
> -                               yylval.integer = (unsigned char)d.val[0];
> -
> -                               if (d.len > 2)
> -                                       lexical_error("Character literal has %d"
> -                                                     " characters instead of 1",
> -                                                     d.len - 1);
> -                       }
> -
> -                       data_free(d);
> -                       return DT_CHAR_LITERAL;
> -               }
> -       YY_BREAK
> -case 13:
> -YY_RULE_SETUP
> -#line 206 "dtc-lexer.l"
> -{      /* label reference */
> -                       DPRINT("Ref: %s\n", yytext+1);
> -                       yylval.labelref = xstrdup(yytext+1);
> -                       return DT_REF;
> -               }
> -       YY_BREAK
> -case 14:
> -YY_RULE_SETUP
> -#line 212 "dtc-lexer.l"
> -{      /* new-style path reference */
> -                       yytext[yyleng-1] = '\0';
> -                       DPRINT("Ref: %s\n", yytext+2);
> -                       yylval.labelref = xstrdup(yytext+2);
> -                       return DT_REF;
> -               }
> -       YY_BREAK
> -case 15:
> -YY_RULE_SETUP
> -#line 219 "dtc-lexer.l"
> -{
> -                       yylval.byte = strtol(yytext, NULL, 16);
> -                       DPRINT("Byte: %02x\n", (int)yylval.byte);
> -                       return DT_BYTE;
> -               }
> -       YY_BREAK
> -case 16:
> -YY_RULE_SETUP
> -#line 225 "dtc-lexer.l"
> -{
> -                       DPRINT("/BYTESTRING\n");
> -                       BEGIN_DEFAULT();
> -                       return ']';
> -               }
> -       YY_BREAK
> -case 17:
> -YY_RULE_SETUP
> -#line 231 "dtc-lexer.l"
> -{
> -                       DPRINT("PropNodeName: %s\n", yytext);
> -                       yylval.propnodename = xstrdup((yytext[0] == '\\') ?
> -                                                       yytext + 1 : yytext);
> -                       BEGIN_DEFAULT();
> -                       return DT_PROPNODENAME;
> -               }
> -       YY_BREAK
> -case 18:
> -YY_RULE_SETUP
> -#line 239 "dtc-lexer.l"
> -{
> -                       DPRINT("Binary Include\n");
> -                       return DT_INCBIN;
> -               }
> -       YY_BREAK
> -case 19:
> -/* rule 19 can match eol */
> -YY_RULE_SETUP
> -#line 244 "dtc-lexer.l"
> -/* eat whitespace */
> -       YY_BREAK
> -case 20:
> -/* rule 20 can match eol */
> -YY_RULE_SETUP
> -#line 245 "dtc-lexer.l"
> -/* eat C-style comments */
> -       YY_BREAK
> -case 21:
> -/* rule 21 can match eol */
> -YY_RULE_SETUP
> -#line 246 "dtc-lexer.l"
> -/* eat C++-style comments */
> -       YY_BREAK
> -case 22:
> -YY_RULE_SETUP
> -#line 248 "dtc-lexer.l"
> -{ return DT_LSHIFT; };
> -       YY_BREAK
> -case 23:
> -YY_RULE_SETUP
> -#line 249 "dtc-lexer.l"
> -{ return DT_RSHIFT; };
> -       YY_BREAK
> -case 24:
> -YY_RULE_SETUP
> -#line 250 "dtc-lexer.l"
> -{ return DT_LE; };
> -       YY_BREAK
> -case 25:
> -YY_RULE_SETUP
> -#line 251 "dtc-lexer.l"
> -{ return DT_GE; };
> -       YY_BREAK
> -case 26:
> -YY_RULE_SETUP
> -#line 252 "dtc-lexer.l"
> -{ return DT_EQ; };
> -       YY_BREAK
> -case 27:
> -YY_RULE_SETUP
> -#line 253 "dtc-lexer.l"
> -{ return DT_NE; };
> -       YY_BREAK
> -case 28:
> -YY_RULE_SETUP
> -#line 254 "dtc-lexer.l"
> -{ return DT_AND; };
> -       YY_BREAK
> -case 29:
> -YY_RULE_SETUP
> -#line 255 "dtc-lexer.l"
> -{ return DT_OR; };
> -       YY_BREAK
> -case 30:
> -YY_RULE_SETUP
> -#line 257 "dtc-lexer.l"
> -{
> -                       DPRINT("Char: %c (\\x%02x)\n", yytext[0],
> -                               (unsigned)yytext[0]);
> -                       if (yytext[0] == '[') {
> -                               DPRINT("<BYTESTRING>\n");
> -                               BEGIN(BYTESTRING);
> -                       }
> -                       if ((yytext[0] == '{')
> -                           || (yytext[0] == ';')) {
> -                               DPRINT("<PROPNODENAME>\n");
> -                               BEGIN(PROPNODENAME);
> -                       }
> -                       return yytext[0];
> -               }
> -       YY_BREAK
> -case 31:
> -YY_RULE_SETUP
> -#line 272 "dtc-lexer.l"
> -ECHO;
> -       YY_BREAK
> -#line 1257 "dtc-lexer.lex.c"
> -
> -       case YY_END_OF_BUFFER:
> -               {
> -               /* Amount of text matched not including the EOB char. */
> -               int yy_amount_of_matched_text = (int) (yy_cp - (yytext_ptr)) - 1;
> -
> -               /* Undo the effects of YY_DO_BEFORE_ACTION. */
> -               *yy_cp = (yy_hold_char);
> -               YY_RESTORE_YY_MORE_OFFSET
> -
> -               if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status == YY_BUFFER_NEW )
> -                       {
> -                       /* We're scanning a new file or input source.  It's
> -                        * possible that this happened because the user
> -                        * just pointed yyin at a new source and called
> -                        * yylex().  If so, then we have to assure
> -                        * consistency between YY_CURRENT_BUFFER and our
> -                        * globals.  Here is the right place to do so, because
> -                        * this is the first action (other than possibly a
> -                        * back-up) that will match for the new input source.
> -                        */
> -                       (yy_n_chars) = YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
> -                       YY_CURRENT_BUFFER_LVALUE->yy_input_file = yyin;
> -                       YY_CURRENT_BUFFER_LVALUE->yy_buffer_status = YY_BUFFER_NORMAL;
> -                       }
> -
> -               /* Note that here we test for yy_c_buf_p "<=" to the position
> -                * of the first EOB in the buffer, since yy_c_buf_p will
> -                * already have been incremented past the NUL character
> -                * (since all states make transitions on EOB to the
> -                * end-of-buffer state).  Contrast this with the test
> -                * in input().
> -                */
> -               if ( (yy_c_buf_p) <= &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] )
> -                       { /* This was really a NUL. */
> -                       yy_state_type yy_next_state;
> -
> -                       (yy_c_buf_p) = (yytext_ptr) + yy_amount_of_matched_text;
> -
> -                       yy_current_state = yy_get_previous_state(  );
> -
> -                       /* Okay, we're now positioned to make the NUL
> -                        * transition.  We couldn't have
> -                        * yy_get_previous_state() go ahead and do it
> -                        * for us because it doesn't know how to deal
> -                        * with the possibility of jamming (and we don't
> -                        * want to build jamming into it because then it
> -                        * will run more slowly).
> -                        */
> -
> -                       yy_next_state = yy_try_NUL_trans( yy_current_state );
> -
> -                       yy_bp = (yytext_ptr) + YY_MORE_ADJ;
> -
> -                       if ( yy_next_state )
> -                               {
> -                               /* Consume the NUL. */
> -                               yy_cp = ++(yy_c_buf_p);
> -                               yy_current_state = yy_next_state;
> -                               goto yy_match;
> -                               }
> -
> -                       else
> -                               {
> -                               yy_cp = (yy_last_accepting_cpos);
> -                               yy_current_state = (yy_last_accepting_state);
> -                               goto yy_find_action;
> -                               }
> -                       }
> -
> -               else switch ( yy_get_next_buffer(  ) )
> -                       {
> -                       case EOB_ACT_END_OF_FILE:
> -                               {
> -                               (yy_did_buffer_switch_on_eof) = 0;
> -
> -                               if ( yywrap( ) )
> -                                       {
> -                                       /* Note: because we've taken care in
> -                                        * yy_get_next_buffer() to have set up
> -                                        * yytext, we can now set up
> -                                        * yy_c_buf_p so that if some total
> -                                        * hoser (like flex itself) wants to
> -                                        * call the scanner after we return the
> -                                        * YY_NULL, it'll still work - another
> -                                        * YY_NULL will get returned.
> -                                        */
> -                                       (yy_c_buf_p) = (yytext_ptr) + YY_MORE_ADJ;
> -
> -                                       yy_act = YY_STATE_EOF(YY_START);
> -                                       goto do_action;
> -                                       }
> -
> -                               else
> -                                       {
> -                                       if ( ! (yy_did_buffer_switch_on_eof) )
> -                                               YY_NEW_FILE;
> -                                       }
> -                               break;
> -                               }
> -
> -                       case EOB_ACT_CONTINUE_SCAN:
> -                               (yy_c_buf_p) =
> -                                       (yytext_ptr) + yy_amount_of_matched_text;
> -
> -                               yy_current_state = yy_get_previous_state(  );
> -
> -                               yy_cp = (yy_c_buf_p);
> -                               yy_bp = (yytext_ptr) + YY_MORE_ADJ;
> -                               goto yy_match;
> -
> -                       case EOB_ACT_LAST_MATCH:
> -                               (yy_c_buf_p) =
> -                               &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)];
> -
> -                               yy_current_state = yy_get_previous_state(  );
> -
> -                               yy_cp = (yy_c_buf_p);
> -                               yy_bp = (yytext_ptr) + YY_MORE_ADJ;
> -                               goto yy_find_action;
> -                       }
> -               break;
> -               }
> -
> -       default:
> -               YY_FATAL_ERROR(
> -                       "fatal flex scanner internal error--no action found" );
> -       } /* end of action switch */
> -               } /* end of scanning one token */
> -       } /* end of user's declarations */
> -} /* end of yylex */
> -
> -/* yy_get_next_buffer - try to read in a new buffer
> - *
> - * Returns a code representing an action:
> - *     EOB_ACT_LAST_MATCH -
> - *     EOB_ACT_CONTINUE_SCAN - continue scanning from current position
> - *     EOB_ACT_END_OF_FILE - end of file
> - */
> -static int yy_get_next_buffer (void)
> -{
> -       char *dest = YY_CURRENT_BUFFER_LVALUE->yy_ch_buf;
> -       char *source = (yytext_ptr);
> -       int number_to_move, i;
> -       int ret_val;
> -
> -       if ( (yy_c_buf_p) > &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) + 1] )
> -               YY_FATAL_ERROR(
> -               "fatal flex scanner internal error--end of buffer missed" );
> -
> -       if ( YY_CURRENT_BUFFER_LVALUE->yy_fill_buffer == 0 )
> -               { /* Don't try to fill the buffer, so this is an EOF. */
> -               if ( (yy_c_buf_p) - (yytext_ptr) - YY_MORE_ADJ == 1 )
> -                       {
> -                       /* We matched a single character, the EOB, so
> -                        * treat this as a final EOF.
> -                        */
> -                       return EOB_ACT_END_OF_FILE;
> -                       }
> -
> -               else
> -                       {
> -                       /* We matched some text prior to the EOB, first
> -                        * process it.
> -                        */
> -                       return EOB_ACT_LAST_MATCH;
> -                       }
> -               }
> -
> -       /* Try to read more data. */
> -
> -       /* First move last chars to start of buffer. */
> -       number_to_move = (int) ((yy_c_buf_p) - (yytext_ptr) - 1);
> -
> -       for ( i = 0; i < number_to_move; ++i )
> -               *(dest++) = *(source++);
> -
> -       if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status == YY_BUFFER_EOF_PENDING )
> -               /* don't do the read, it's not guaranteed to return an EOF,
> -                * just force an EOF
> -                */
> -               YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars) = 0;
> -
> -       else
> -               {
> -                       int num_to_read =
> -                       YY_CURRENT_BUFFER_LVALUE->yy_buf_size - number_to_move - 1;
> -
> -               while ( num_to_read <= 0 )
> -                       { /* Not enough room in the buffer - grow it. */
> -
> -                       /* just a shorter name for the current buffer */
> -                       YY_BUFFER_STATE b = YY_CURRENT_BUFFER_LVALUE;
> -
> -                       int yy_c_buf_p_offset =
> -                               (int) ((yy_c_buf_p) - b->yy_ch_buf);
> -
> -                       if ( b->yy_is_our_buffer )
> -                               {
> -                               int new_size = b->yy_buf_size * 2;
> -
> -                               if ( new_size <= 0 )
> -                                       b->yy_buf_size += b->yy_buf_size / 8;
> -                               else
> -                                       b->yy_buf_size *= 2;
> -
> -                               b->yy_ch_buf = (char *)
> -                                       /* Include room in for 2 EOB chars. */
> -                                       yyrealloc((void *) b->yy_ch_buf,b->yy_buf_size + 2  );
> -                               }
> -                       else
> -                               /* Can't grow it, we don't own it. */
> -                               b->yy_ch_buf = NULL;
> -
> -                       if ( ! b->yy_ch_buf )
> -                               YY_FATAL_ERROR(
> -                               "fatal error - scanner input buffer overflow" );
> -
> -                       (yy_c_buf_p) = &b->yy_ch_buf[yy_c_buf_p_offset];
> -
> -                       num_to_read = YY_CURRENT_BUFFER_LVALUE->yy_buf_size -
> -                                               number_to_move - 1;
> -
> -                       }
> -
> -               if ( num_to_read > YY_READ_BUF_SIZE )
> -                       num_to_read = YY_READ_BUF_SIZE;
> -
> -               /* Read in more data. */
> -               YY_INPUT( (&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move]),
> -                       (yy_n_chars), num_to_read );
> -
> -               YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
> -               }
> -
> -       if ( (yy_n_chars) == 0 )
> -               {
> -               if ( number_to_move == YY_MORE_ADJ )
> -                       {
> -                       ret_val = EOB_ACT_END_OF_FILE;
> -                       yyrestart(yyin  );
> -                       }
> -
> -               else
> -                       {
> -                       ret_val = EOB_ACT_LAST_MATCH;
> -                       YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =
> -                               YY_BUFFER_EOF_PENDING;
> -                       }
> -               }
> -
> -       else
> -               ret_val = EOB_ACT_CONTINUE_SCAN;
> -
> -       if (((yy_n_chars) + number_to_move) > YY_CURRENT_BUFFER_LVALUE->yy_buf_size) {
> -               /* Extend the array by 50%, plus the number we really need. */
> -               int new_size = (yy_n_chars) + number_to_move + ((yy_n_chars) >> 1);
> -               YY_CURRENT_BUFFER_LVALUE->yy_ch_buf = (char *) yyrealloc((void *) YY_CURRENT_BUFFER_LVALUE->yy_ch_buf,new_size  );
> -               if ( ! YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
> -                       YY_FATAL_ERROR( "out of dynamic memory in yy_get_next_buffer()" );
> -       }
> -
> -       (yy_n_chars) += number_to_move;
> -       YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] = YY_END_OF_BUFFER_CHAR;
> -       YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) + 1] = YY_END_OF_BUFFER_CHAR;
> -
> -       (yytext_ptr) = &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[0];
> -
> -       return ret_val;
> -}
> -
> -/* yy_get_previous_state - get the state just before the EOB char was reached */
> -
> -    static yy_state_type yy_get_previous_state (void)
> -{
> -       yy_state_type yy_current_state;
> -       char *yy_cp;
> -
> -       yy_current_state = (yy_start);
> -       yy_current_state += YY_AT_BOL();
> -
> -       for ( yy_cp = (yytext_ptr) + YY_MORE_ADJ; yy_cp < (yy_c_buf_p); ++yy_cp )
> -               {
> -               YY_CHAR yy_c = (*yy_cp ? yy_ec[YY_SC_TO_UI(*yy_cp)] : 1);
> -               if ( yy_accept[yy_current_state] )
> -                       {
> -                       (yy_last_accepting_state) = yy_current_state;
> -                       (yy_last_accepting_cpos) = yy_cp;
> -                       }
> -               while ( yy_chk[yy_base[yy_current_state] + yy_c] != yy_current_state )
> -                       {
> -                       yy_current_state = (int) yy_def[yy_current_state];
> -                       if ( yy_current_state >= 166 )
> -                               yy_c = yy_meta[(unsigned int) yy_c];
> -                       }
> -               yy_current_state = yy_nxt[yy_base[yy_current_state] + (flex_int16_t) yy_c];
> -               }
> -
> -       return yy_current_state;
> -}
> -
> -/* yy_try_NUL_trans - try to make a transition on the NUL character
> - *
> - * synopsis
> - *     next_state = yy_try_NUL_trans( current_state );
> - */
> -    static yy_state_type yy_try_NUL_trans  (yy_state_type yy_current_state )
> -{
> -       int yy_is_jam;
> -       char *yy_cp = (yy_c_buf_p);
> -
> -       YY_CHAR yy_c = 1;
> -       if ( yy_accept[yy_current_state] )
> -               {
> -               (yy_last_accepting_state) = yy_current_state;
> -               (yy_last_accepting_cpos) = yy_cp;
> -               }
> -       while ( yy_chk[yy_base[yy_current_state] + yy_c] != yy_current_state )
> -               {
> -               yy_current_state = (int) yy_def[yy_current_state];
> -               if ( yy_current_state >= 166 )
> -                       yy_c = yy_meta[(unsigned int) yy_c];
> -               }
> -       yy_current_state = yy_nxt[yy_base[yy_current_state] + (flex_int16_t) yy_c];
> -       yy_is_jam = (yy_current_state == 165);
> -
> -               return yy_is_jam ? 0 : yy_current_state;
> -}
> -
> -#ifndef YY_NO_UNPUT
> -
> -#endif
> -
> -#ifndef YY_NO_INPUT
> -#ifdef __cplusplus
> -    static int yyinput (void)
> -#else
> -    static int input  (void)
> -#endif
> -
> -{
> -       int c;
> -
> -       *(yy_c_buf_p) = (yy_hold_char);
> -
> -       if ( *(yy_c_buf_p) == YY_END_OF_BUFFER_CHAR )
> -               {
> -               /* yy_c_buf_p now points to the character we want to return.
> -                * If this occurs *before* the EOB characters, then it's a
> -                * valid NUL; if not, then we've hit the end of the buffer.
> -                */
> -               if ( (yy_c_buf_p) < &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] )
> -                       /* This was really a NUL. */
> -                       *(yy_c_buf_p) = '\0';
> -
> -               else
> -                       { /* need more input */
> -                       int offset = (yy_c_buf_p) - (yytext_ptr);
> -                       ++(yy_c_buf_p);
> -
> -                       switch ( yy_get_next_buffer(  ) )
> -                               {
> -                               case EOB_ACT_LAST_MATCH:
> -                                       /* This happens because yy_g_n_b()
> -                                        * sees that we've accumulated a
> -                                        * token and flags that we need to
> -                                        * try matching the token before
> -                                        * proceeding.  But for input(),
> -                                        * there's no matching to consider.
> -                                        * So convert the EOB_ACT_LAST_MATCH
> -                                        * to EOB_ACT_END_OF_FILE.
> -                                        */
> -
> -                                       /* Reset buffer status. */
> -                                       yyrestart(yyin );
> -
> -                                       /*FALLTHROUGH*/
> -
> -                               case EOB_ACT_END_OF_FILE:
> -                                       {
> -                                       if ( yywrap( ) )
> -                                               return 0;
> -
> -                                       if ( ! (yy_did_buffer_switch_on_eof) )
> -                                               YY_NEW_FILE;
> -#ifdef __cplusplus
> -                                       return yyinput();
> -#else
> -                                       return input();
> -#endif
> -                                       }
> -
> -                               case EOB_ACT_CONTINUE_SCAN:
> -                                       (yy_c_buf_p) = (yytext_ptr) + offset;
> -                                       break;
> -                               }
> -                       }
> -               }
> -
> -       c = *(unsigned char *) (yy_c_buf_p);    /* cast for 8-bit char's */
> -       *(yy_c_buf_p) = '\0';   /* preserve yytext */
> -       (yy_hold_char) = *++(yy_c_buf_p);
> -
> -       YY_CURRENT_BUFFER_LVALUE->yy_at_bol = (c == '\n');
> -
> -       return c;
> -}
> -#endif /* ifndef YY_NO_INPUT */
> -
> -/** Immediately switch to a different input stream.
> - * @param input_file A readable stream.
> - *
> - * @note This function does not reset the start condition to @c INITIAL .
> - */
> -    void yyrestart  (FILE * input_file )
> -{
> -
> -       if ( ! YY_CURRENT_BUFFER ){
> -        yyensure_buffer_stack ();
> -               YY_CURRENT_BUFFER_LVALUE =
> -            yy_create_buffer(yyin,YY_BUF_SIZE );
> -       }
> -
> -       yy_init_buffer(YY_CURRENT_BUFFER,input_file );
> -       yy_load_buffer_state( );
> -}
> -
> -/** Switch to a different input buffer.
> - * @param new_buffer The new input buffer.
> - *
> - */
> -    void yy_switch_to_buffer  (YY_BUFFER_STATE  new_buffer )
> -{
> -
> -       /* TODO. We should be able to replace this entire function body
> -        * with
> -        *              yypop_buffer_state();
> -        *              yypush_buffer_state(new_buffer);
> -     */
> -       yyensure_buffer_stack ();
> -       if ( YY_CURRENT_BUFFER == new_buffer )
> -               return;
> -
> -       if ( YY_CURRENT_BUFFER )
> -               {
> -               /* Flush out information for old buffer. */
> -               *(yy_c_buf_p) = (yy_hold_char);
> -               YY_CURRENT_BUFFER_LVALUE->yy_buf_pos = (yy_c_buf_p);
> -               YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
> -               }
> -
> -       YY_CURRENT_BUFFER_LVALUE = new_buffer;
> -       yy_load_buffer_state( );
> -
> -       /* We don't actually know whether we did this switch during
> -        * EOF (yywrap()) processing, but the only time this flag
> -        * is looked at is after yywrap() is called, so it's safe
> -        * to go ahead and always set it.
> -        */
> -       (yy_did_buffer_switch_on_eof) = 1;
> -}
> -
> -static void yy_load_buffer_state  (void)
> -{
> -       (yy_n_chars) = YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
> -       (yytext_ptr) = (yy_c_buf_p) = YY_CURRENT_BUFFER_LVALUE->yy_buf_pos;
> -       yyin = YY_CURRENT_BUFFER_LVALUE->yy_input_file;
> -       (yy_hold_char) = *(yy_c_buf_p);
> -}
> -
> -/** Allocate and initialize an input buffer state.
> - * @param file A readable stream.
> - * @param size The character buffer size in bytes. When in doubt, use @c YY_BUF_SIZE.
> - *
> - * @return the allocated buffer state.
> - */
> -    YY_BUFFER_STATE yy_create_buffer  (FILE * file, int  size )
> -{
> -       YY_BUFFER_STATE b;
> -
> -       b = (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
> -       if ( ! b )
> -               YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
> -
> -       b->yy_buf_size = (yy_size_t)size;
> -
> -       /* yy_ch_buf has to be 2 characters longer than the size given because
> -        * we need to put in 2 end-of-buffer characters.
> -        */
> -       b->yy_ch_buf = (char *) yyalloc(b->yy_buf_size + 2  );
> -       if ( ! b->yy_ch_buf )
> -               YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
> -
> -       b->yy_is_our_buffer = 1;
> -
> -       yy_init_buffer(b,file );
> -
> -       return b;
> -}
> -
> -/** Destroy the buffer.
> - * @param b a buffer created with yy_create_buffer()
> - *
> - */
> -    void yy_delete_buffer (YY_BUFFER_STATE  b )
> -{
> -
> -       if ( ! b )
> -               return;
> -
> -       if ( b == YY_CURRENT_BUFFER ) /* Not sure if we should pop here. */
> -               YY_CURRENT_BUFFER_LVALUE = (YY_BUFFER_STATE) 0;
> -
> -       if ( b->yy_is_our_buffer )
> -               yyfree((void *) b->yy_ch_buf  );
> -
> -       yyfree((void *) b  );
> -}
> -
> -/* Initializes or reinitializes a buffer.
> - * This function is sometimes called more than once on the same buffer,
> - * such as during a yyrestart() or at EOF.
> - */
> -    static void yy_init_buffer  (YY_BUFFER_STATE  b, FILE * file )
> -
> -{
> -       int oerrno = errno;
> -
> -       yy_flush_buffer(b );
> -
> -       b->yy_input_file = file;
> -       b->yy_fill_buffer = 1;
> -
> -    /* If b is the current buffer, then yy_init_buffer was _probably_
> -     * called from yyrestart() or through yy_get_next_buffer.
> -     * In that case, we don't want to reset the lineno or column.
> -     */
> -    if (b != YY_CURRENT_BUFFER){
> -        b->yy_bs_lineno = 1;
> -        b->yy_bs_column = 0;
> -    }
> -
> -        b->yy_is_interactive = 0;
> -
> -       errno = oerrno;
> -}
> -
> -/** Discard all buffered characters. On the next scan, YY_INPUT will be called.
> - * @param b the buffer state to be flushed, usually @c YY_CURRENT_BUFFER.
> - *
> - */
> -    void yy_flush_buffer (YY_BUFFER_STATE  b )
> -{
> -       if ( ! b )
> -               return;
> -
> -       b->yy_n_chars = 0;
> -
> -       /* We always need two end-of-buffer characters.  The first causes
> -        * a transition to the end-of-buffer state.  The second causes
> -        * a jam in that state.
> -        */
> -       b->yy_ch_buf[0] = YY_END_OF_BUFFER_CHAR;
> -       b->yy_ch_buf[1] = YY_END_OF_BUFFER_CHAR;
> -
> -       b->yy_buf_pos = &b->yy_ch_buf[0];
> -
> -       b->yy_at_bol = 1;
> -       b->yy_buffer_status = YY_BUFFER_NEW;
> -
> -       if ( b == YY_CURRENT_BUFFER )
> -               yy_load_buffer_state( );
> -}
> -
> -/** Pushes the new state onto the stack. The new state becomes
> - *  the current state. This function will allocate the stack
> - *  if necessary.
> - *  @param new_buffer The new state.
> - *
> - */
> -void yypush_buffer_state (YY_BUFFER_STATE new_buffer )
> -{
> -       if (new_buffer == NULL)
> -               return;
> -
> -       yyensure_buffer_stack();
> -
> -       /* This block is copied from yy_switch_to_buffer. */
> -       if ( YY_CURRENT_BUFFER )
> -               {
> -               /* Flush out information for old buffer. */
> -               *(yy_c_buf_p) = (yy_hold_char);
> -               YY_CURRENT_BUFFER_LVALUE->yy_buf_pos = (yy_c_buf_p);
> -               YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
> -               }
> -
> -       /* Only push if top exists. Otherwise, replace top. */
> -       if (YY_CURRENT_BUFFER)
> -               (yy_buffer_stack_top)++;
> -       YY_CURRENT_BUFFER_LVALUE = new_buffer;
> -
> -       /* copied from yy_switch_to_buffer. */
> -       yy_load_buffer_state( );
> -       (yy_did_buffer_switch_on_eof) = 1;
> -}
> -
> -/** Removes and deletes the top of the stack, if present.
> - *  The next element becomes the new top.
> - *
> - */
> -void yypop_buffer_state (void)
> -{
> -       if (!YY_CURRENT_BUFFER)
> -               return;
> -
> -       yy_delete_buffer(YY_CURRENT_BUFFER );
> -       YY_CURRENT_BUFFER_LVALUE = NULL;
> -       if ((yy_buffer_stack_top) > 0)
> -               --(yy_buffer_stack_top);
> -
> -       if (YY_CURRENT_BUFFER) {
> -               yy_load_buffer_state( );
> -               (yy_did_buffer_switch_on_eof) = 1;
> -       }
> -}
> -
> -/* Allocates the stack if it does not exist.
> - *  Guarantees space for at least one push.
> - */
> -static void yyensure_buffer_stack (void)
> -{
> -       int num_to_alloc;
> -
> -       if (!(yy_buffer_stack)) {
> -
> -               /* First allocation is just for 2 elements, since we don't know if this
> -                * scanner will even need a stack. We use 2 instead of 1 to avoid an
> -                * immediate realloc on the next call.
> -         */
> -      num_to_alloc = 1; /* After all that talk, this was set to 1 anyways... */
> -               (yy_buffer_stack) = (struct yy_buffer_state**)yyalloc
> -                                                               (num_to_alloc * sizeof(struct yy_buffer_state*)
> -                                                               );
> -               if ( ! (yy_buffer_stack) )
> -                       YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" );
> -
> -               memset((yy_buffer_stack), 0, num_to_alloc * sizeof(struct yy_buffer_state*));
> -
> -               (yy_buffer_stack_max) = num_to_alloc;
> -               (yy_buffer_stack_top) = 0;
> -               return;
> -       }
> -
> -       if ((yy_buffer_stack_top) >= ((yy_buffer_stack_max)) - 1){
> -
> -               /* Increase the buffer to prepare for a possible push. */
> -               yy_size_t grow_size = 8 /* arbitrary grow size */;
> -
> -               num_to_alloc = (yy_buffer_stack_max) + grow_size;
> -               (yy_buffer_stack) = (struct yy_buffer_state**)yyrealloc
> -                                                               ((yy_buffer_stack),
> -                                                               num_to_alloc * sizeof(struct yy_buffer_state*)
> -                                                               );
> -               if ( ! (yy_buffer_stack) )
> -                       YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" );
> -
> -               /* zero only the new slots.*/
> -               memset((yy_buffer_stack) + (yy_buffer_stack_max), 0, grow_size * sizeof(struct yy_buffer_state*));
> -               (yy_buffer_stack_max) = num_to_alloc;
> -       }
> -}
> -
> -/** Setup the input buffer state to scan directly from a user-specified character buffer.
> - * @param base the character buffer
> - * @param size the size in bytes of the character buffer
> - *
> - * @return the newly allocated buffer state object.
> - */
> -YY_BUFFER_STATE yy_scan_buffer  (char * base, yy_size_t  size )
> -{
> -       YY_BUFFER_STATE b;
> -
> -       if ( size < 2 ||
> -            base[size-2] != YY_END_OF_BUFFER_CHAR ||
> -            base[size-1] != YY_END_OF_BUFFER_CHAR )
> -               /* They forgot to leave room for the EOB's. */
> -               return NULL;
> -
> -       b = (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
> -       if ( ! b )
> -               YY_FATAL_ERROR( "out of dynamic memory in yy_scan_buffer()" );
> -
> -       b->yy_buf_size = size - 2;      /* "- 2" to take care of EOB's */
> -       b->yy_buf_pos = b->yy_ch_buf = base;
> -       b->yy_is_our_buffer = 0;
> -       b->yy_input_file = NULL;
> -       b->yy_n_chars = b->yy_buf_size;
> -       b->yy_is_interactive = 0;
> -       b->yy_at_bol = 1;
> -       b->yy_fill_buffer = 0;
> -       b->yy_buffer_status = YY_BUFFER_NEW;
> -
> -       yy_switch_to_buffer(b  );
> -
> -       return b;
> -}
> -
> -/** Setup the input buffer state to scan a string. The next call to yylex() will
> - * scan from a @e copy of @a str.
> - * @param yystr a NUL-terminated string to scan
> - *
> - * @return the newly allocated buffer state object.
> - * @note If you want to scan bytes that may contain NUL values, then use
> - *       yy_scan_bytes() instead.
> - */
> -YY_BUFFER_STATE yy_scan_string (yyconst char * yystr )
> -{
> -
> -       return yy_scan_bytes(yystr,(int) strlen(yystr) );
> -}
> -
> -/** Setup the input buffer state to scan the given bytes. The next call to yylex() will
> - * scan from a @e copy of @a bytes.
> - * @param yybytes the byte buffer to scan
> - * @param _yybytes_len the number of bytes in the buffer pointed to by @a bytes.
> - *
> - * @return the newly allocated buffer state object.
> - */
> -YY_BUFFER_STATE yy_scan_bytes  (yyconst char * yybytes, int  _yybytes_len )
> -{
> -       YY_BUFFER_STATE b;
> -       char *buf;
> -       yy_size_t n;
> -       int i;
> -
> -       /* Get memory for full buffer, including space for trailing EOB's. */
> -       n = (yy_size_t) (_yybytes_len + 2);
> -       buf = (char *) yyalloc(n  );
> -       if ( ! buf )
> -               YY_FATAL_ERROR( "out of dynamic memory in yy_scan_bytes()" );
> -
> -       for ( i = 0; i < _yybytes_len; ++i )
> -               buf[i] = yybytes[i];
> -
> -       buf[_yybytes_len] = buf[_yybytes_len+1] = YY_END_OF_BUFFER_CHAR;
> -
> -       b = yy_scan_buffer(buf,n );
> -       if ( ! b )
> -               YY_FATAL_ERROR( "bad buffer in yy_scan_bytes()" );
> -
> -       /* It's okay to grow etc. this buffer, and we should throw it
> -        * away when we're done.
> -        */
> -       b->yy_is_our_buffer = 1;
> -
> -       return b;
> -}
> -
> -#ifndef YY_EXIT_FAILURE
> -#define YY_EXIT_FAILURE 2
> -#endif
> -
> -static void yynoreturn yy_fatal_error (yyconst char* msg )
> -{
> -                       (void) fprintf( stderr, "%s\n", msg );
> -       exit( YY_EXIT_FAILURE );
> -}
> -
> -/* Redefine yyless() so it works in section 3 code. */
> -
> -#undef yyless
> -#define yyless(n) \
> -       do \
> -               { \
> -               /* Undo effects of setting up yytext. */ \
> -        int yyless_macro_arg = (n); \
> -        YY_LESS_LINENO(yyless_macro_arg);\
> -               yytext[yyleng] = (yy_hold_char); \
> -               (yy_c_buf_p) = yytext + yyless_macro_arg; \
> -               (yy_hold_char) = *(yy_c_buf_p); \
> -               *(yy_c_buf_p) = '\0'; \
> -               yyleng = yyless_macro_arg; \
> -               } \
> -       while ( 0 )
> -
> -/* Accessor  methods (get/set functions) to struct members. */
> -
> -/** Get the current line number.
> - *
> - */
> -int yyget_lineno  (void)
> -{
> -
> -    return yylineno;
> -}
> -
> -/** Get the input stream.
> - *
> - */
> -FILE *yyget_in  (void)
> -{
> -        return yyin;
> -}
> -
> -/** Get the output stream.
> - *
> - */
> -FILE *yyget_out  (void)
> -{
> -        return yyout;
> -}
> -
> -/** Get the length of the current token.
> - *
> - */
> -int yyget_leng  (void)
> -{
> -        return yyleng;
> -}
> -
> -/** Get the current token.
> - *
> - */
> -
> -char *yyget_text  (void)
> -{
> -        return yytext;
> -}
> -
> -/** Set the current line number.
> - * @param _line_number line number
> - *
> - */
> -void yyset_lineno (int  _line_number )
> -{
> -
> -    yylineno = _line_number;
> -}
> -
> -/** Set the input stream. This does not discard the current
> - * input buffer.
> - * @param _in_str A readable stream.
> - *
> - * @see yy_switch_to_buffer
> - */
> -void yyset_in (FILE *  _in_str )
> -{
> -        yyin = _in_str ;
> -}
> -
> -void yyset_out (FILE *  _out_str )
> -{
> -        yyout = _out_str ;
> -}
> -
> -int yyget_debug  (void)
> -{
> -        return yy_flex_debug;
> -}
> -
> -void yyset_debug (int  _bdebug )
> -{
> -        yy_flex_debug = _bdebug ;
> -}
> -
> -static int yy_init_globals (void)
> -{
> -        /* Initialization is the same as for the non-reentrant scanner.
> -     * This function is called from yylex_destroy(), so don't allocate here.
> -     */
> -
> -    (yy_buffer_stack) = NULL;
> -    (yy_buffer_stack_top) = 0;
> -    (yy_buffer_stack_max) = 0;
> -    (yy_c_buf_p) = NULL;
> -    (yy_init) = 0;
> -    (yy_start) = 0;
> -
> -/* Defined in main.c */
> -#ifdef YY_STDINIT
> -    yyin = stdin;
> -    yyout = stdout;
> -#else
> -    yyin = NULL;
> -    yyout = NULL;
> -#endif
> -
> -    /* For future reference: Set errno on error, since we are called by
> -     * yylex_init()
> -     */
> -    return 0;
> -}
> -
> -/* yylex_destroy is for both reentrant and non-reentrant scanners. */
> -int yylex_destroy  (void)
> -{
> -
> -    /* Pop the buffer stack, destroying each element. */
> -       while(YY_CURRENT_BUFFER){
> -               yy_delete_buffer(YY_CURRENT_BUFFER  );
> -               YY_CURRENT_BUFFER_LVALUE = NULL;
> -               yypop_buffer_state();
> -       }
> -
> -       /* Destroy the stack itself. */
> -       yyfree((yy_buffer_stack) );
> -       (yy_buffer_stack) = NULL;
> -
> -    /* Reset the globals. This is important in a non-reentrant scanner so the next time
> -     * yylex() is called, initialization will occur. */
> -    yy_init_globals( );
> -
> -    return 0;
> -}
> -
> -/*
> - * Internal utility routines.
> - */
> -
> -#ifndef yytext_ptr
> -static void yy_flex_strncpy (char* s1, yyconst char * s2, int n )
> -{
> -
> -       int i;
> -       for ( i = 0; i < n; ++i )
> -               s1[i] = s2[i];
> -}
> -#endif
> -
> -#ifdef YY_NEED_STRLEN
> -static int yy_flex_strlen (yyconst char * s )
> -{
> -       int n;
> -       for ( n = 0; s[n]; ++n )
> -               ;
> -
> -       return n;
> -}
> -#endif
> -
> -void *yyalloc (yy_size_t  size )
> -{
> -                       return malloc(size);
> -}
> -
> -void *yyrealloc  (void * ptr, yy_size_t  size )
> -{
> -
> -       /* The cast to (char *) in the following accommodates both
> -        * implementations that use char* generic pointers, and those
> -        * that use void* generic pointers.  It works with the latter
> -        * because both ANSI C and C++ allow castless assignment from
> -        * any pointer type to void*, and deal with argument conversions
> -        * as though doing an assignment.
> -        */
> -       return realloc(ptr, size);
> -}
> -
> -void yyfree (void * ptr )
> -{
> -                       free( (char *) ptr );   /* see yyrealloc() for (char *) cast */
> -}
> -
> -#define YYTABLES_NAME "yytables"
> -
> -#line 272 "dtc-lexer.l"
> -
> -
> -
> -static void push_input_file(const char *filename)
> -{
> -       assert(filename);
> -
> -       srcfile_push(filename);
> -
> -       yyin = current_srcfile->f;
> -
> -       yypush_buffer_state(yy_create_buffer(yyin,YY_BUF_SIZE));
> -}
> -
> -
> -static bool pop_input_file(void)
> -{
> -       if (srcfile_pop() == 0)
> -               return false;
> -
> -       yypop_buffer_state();
> -       yyin = current_srcfile->f;
> -
> -       return true;
> -}
> -
> -static void lexical_error(const char *fmt, ...)
> -{
> -       va_list ap;
> -
> -       va_start(ap, fmt);
> -       srcpos_verror(&yylloc, "Lexical error", fmt, ap);
> -       va_end(ap);
> -
> -       treesource_error = true;
> -}
> -
> diff --git a/scripts/dtc/dtc-parser.tab.c_shipped b/scripts/dtc/dtc-parser.tab.c_shipped
> deleted file mode 100644
> index aea514fa6928..000000000000
> --- a/scripts/dtc/dtc-parser.tab.c_shipped
> +++ /dev/null
> @@ -1,2321 +0,0 @@
> -/* A Bison parser, made by GNU Bison 3.0.4.  */
> -
> -/* Bison implementation for Yacc-like parsers in C
> -
> -   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.
> -
> -   This program is free software: you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License as published by
> -   the Free Software Foundation, either version 3 of the License, or
> -   (at your option) any later version.
> -
> -   This program is distributed in the hope that it will be useful,
> -   but WITHOUT ANY WARRANTY; without even the implied warranty of
> -   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -   GNU General Public License for more details.
> -
> -   You should have received a copy of the GNU General Public License
> -   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
> -
> -/* As a special exception, you may create a larger work that contains
> -   part or all of the Bison parser skeleton and distribute that work
> -   under terms of your choice, so long as that work isn't itself a
> -   parser generator using the skeleton or a modified version thereof
> -   as a parser skeleton.  Alternatively, if you modify or redistribute
> -   the parser skeleton itself, you may (at your option) remove this
> -   special exception, which will cause the skeleton and the resulting
> -   Bison output files to be licensed under the GNU General Public
> -   License without this special exception.
> -
> -   This special exception was added by the Free Software Foundation in
> -   version 2.2 of Bison.  */
> -
> -/* C LALR(1) parser skeleton written by Richard Stallman, by
> -   simplifying the original so-called "semantic" parser.  */
> -
> -/* All symbols defined below should begin with yy or YY, to avoid
> -   infringing on user name space.  This should be done even for local
> -   variables, as they might otherwise be expanded by user macros.
> -   There are some unavoidable exceptions within include files to
> -   define necessary library symbols; they are noted "INFRINGES ON
> -   USER NAME SPACE" below.  */
> -
> -/* Identify Bison output.  */
> -#define YYBISON 1
> -
> -/* Bison version.  */
> -#define YYBISON_VERSION "3.0.4"
> -
> -/* Skeleton name.  */
> -#define YYSKELETON_NAME "yacc.c"
> -
> -/* Pure parsers.  */
> -#define YYPURE 0
> -
> -/* Push parsers.  */
> -#define YYPUSH 0
> -
> -/* Pull parsers.  */
> -#define YYPULL 1
> -
> -
> -
> -
> -/* Copy the first part of user declarations.  */
> -#line 20 "dtc-parser.y" /* yacc.c:339  */
> -
> -#include <stdio.h>
> -#include <inttypes.h>
> -
> -#include "dtc.h"
> -#include "srcpos.h"
> -
> -extern int yylex(void);
> -extern void yyerror(char const *s);
> -#define ERROR(loc, ...) \
> -       do { \
> -               srcpos_error((loc), "Error", __VA_ARGS__); \
> -               treesource_error = true; \
> -       } while (0)
> -
> -extern struct dt_info *parser_output;
> -extern bool treesource_error;
> -
> -#line 85 "dtc-parser.tab.c" /* yacc.c:339  */
> -
> -# ifndef YY_NULLPTR
> -#  if defined __cplusplus && 201103L <= __cplusplus
> -#   define YY_NULLPTR nullptr
> -#  else
> -#   define YY_NULLPTR 0
> -#  endif
> -# endif
> -
> -/* Enabling verbose error messages.  */
> -#ifdef YYERROR_VERBOSE
> -# undef YYERROR_VERBOSE
> -# define YYERROR_VERBOSE 1
> -#else
> -# define YYERROR_VERBOSE 0
> -#endif
> -
> -/* In a future release of Bison, this section will be replaced
> -   by #include "dtc-parser.tab.h".  */
> -#ifndef YY_YY_DTC_PARSER_TAB_H_INCLUDED
> -# define YY_YY_DTC_PARSER_TAB_H_INCLUDED
> -/* Debug traces.  */
> -#ifndef YYDEBUG
> -# define YYDEBUG 0
> -#endif
> -#if YYDEBUG
> -extern int yydebug;
> -#endif
> -
> -/* Token type.  */
> -#ifndef YYTOKENTYPE
> -# define YYTOKENTYPE
> -  enum yytokentype
> -  {
> -    DT_V1 = 258,
> -    DT_PLUGIN = 259,
> -    DT_MEMRESERVE = 260,
> -    DT_LSHIFT = 261,
> -    DT_RSHIFT = 262,
> -    DT_LE = 263,
> -    DT_GE = 264,
> -    DT_EQ = 265,
> -    DT_NE = 266,
> -    DT_AND = 267,
> -    DT_OR = 268,
> -    DT_BITS = 269,
> -    DT_DEL_PROP = 270,
> -    DT_DEL_NODE = 271,
> -    DT_PROPNODENAME = 272,
> -    DT_LITERAL = 273,
> -    DT_CHAR_LITERAL = 274,
> -    DT_BYTE = 275,
> -    DT_STRING = 276,
> -    DT_LABEL = 277,
> -    DT_REF = 278,
> -    DT_INCBIN = 279
> -  };
> -#endif
> -
> -/* Value type.  */
> -#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
> -
> -union YYSTYPE
> -{
> -#line 39 "dtc-parser.y" /* yacc.c:355  */
> -
> -       char *propnodename;
> -       char *labelref;
> -       uint8_t byte;
> -       struct data data;
> -
> -       struct {
> -               struct data     data;
> -               int             bits;
> -       } array;
> -
> -       struct property *prop;
> -       struct property *proplist;
> -       struct node *node;
> -       struct node *nodelist;
> -       struct reserve_info *re;
> -       uint64_t integer;
> -       unsigned int flags;
> -
> -#line 170 "dtc-parser.tab.c" /* yacc.c:355  */
> -};
> -
> -typedef union YYSTYPE YYSTYPE;
> -# define YYSTYPE_IS_TRIVIAL 1
> -# define YYSTYPE_IS_DECLARED 1
> -#endif
> -
> -/* Location type.  */
> -#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
> -typedef struct YYLTYPE YYLTYPE;
> -struct YYLTYPE
> -{
> -  int first_line;
> -  int first_column;
> -  int last_line;
> -  int last_column;
> -};
> -# define YYLTYPE_IS_DECLARED 1
> -# define YYLTYPE_IS_TRIVIAL 1
> -#endif
> -
> -
> -extern YYSTYPE yylval;
> -extern YYLTYPE yylloc;
> -int yyparse (void);
> -
> -#endif /* !YY_YY_DTC_PARSER_TAB_H_INCLUDED  */
> -
> -/* Copy the second part of user declarations.  */
> -
> -#line 201 "dtc-parser.tab.c" /* yacc.c:358  */
> -
> -#ifdef short
> -# undef short
> -#endif
> -
> -#ifdef YYTYPE_UINT8
> -typedef YYTYPE_UINT8 yytype_uint8;
> -#else
> -typedef unsigned char yytype_uint8;
> -#endif
> -
> -#ifdef YYTYPE_INT8
> -typedef YYTYPE_INT8 yytype_int8;
> -#else
> -typedef signed char yytype_int8;
> -#endif
> -
> -#ifdef YYTYPE_UINT16
> -typedef YYTYPE_UINT16 yytype_uint16;
> -#else
> -typedef unsigned short int yytype_uint16;
> -#endif
> -
> -#ifdef YYTYPE_INT16
> -typedef YYTYPE_INT16 yytype_int16;
> -#else
> -typedef short int yytype_int16;
> -#endif
> -
> -#ifndef YYSIZE_T
> -# ifdef __SIZE_TYPE__
> -#  define YYSIZE_T __SIZE_TYPE__
> -# elif defined size_t
> -#  define YYSIZE_T size_t
> -# elif ! defined YYSIZE_T
> -#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
> -#  define YYSIZE_T size_t
> -# else
> -#  define YYSIZE_T unsigned int
> -# endif
> -#endif
> -
> -#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)
> -
> -#ifndef YY_
> -# if defined YYENABLE_NLS && YYENABLE_NLS
> -#  if ENABLE_NLS
> -#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
> -#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
> -#  endif
> -# endif
> -# ifndef YY_
> -#  define YY_(Msgid) Msgid
> -# endif
> -#endif
> -
> -#ifndef YY_ATTRIBUTE
> -# if (defined __GNUC__                                               \
> -      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
> -     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
> -#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
> -# else
> -#  define YY_ATTRIBUTE(Spec) /* empty */
> -# endif
> -#endif
> -
> -#ifndef YY_ATTRIBUTE_PURE
> -# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
> -#endif
> -
> -#ifndef YY_ATTRIBUTE_UNUSED
> -# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
> -#endif
> -
> -#if !defined _Noreturn \
> -     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
> -# if defined _MSC_VER && 1200 <= _MSC_VER
> -#  define _Noreturn __declspec (noreturn)
> -# else
> -#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
> -# endif
> -#endif
> -
> -/* Suppress unused-variable warnings by "using" E.  */
> -#if ! defined lint || defined __GNUC__
> -# define YYUSE(E) ((void) (E))
> -#else
> -# define YYUSE(E) /* empty */
> -#endif
> -
> -#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
> -/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
> -# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
> -    _Pragma ("GCC diagnostic push") \
> -    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
> -    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
> -# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
> -    _Pragma ("GCC diagnostic pop")
> -#else
> -# define YY_INITIAL_VALUE(Value) Value
> -#endif
> -#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
> -# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
> -# define YY_IGNORE_MAYBE_UNINITIALIZED_END
> -#endif
> -#ifndef YY_INITIAL_VALUE
> -# define YY_INITIAL_VALUE(Value) /* Nothing. */
> -#endif
> -
> -
> -#if ! defined yyoverflow || YYERROR_VERBOSE
> -
> -/* The parser invokes alloca or malloc; define the necessary symbols.  */
> -
> -# ifdef YYSTACK_USE_ALLOCA
> -#  if YYSTACK_USE_ALLOCA
> -#   ifdef __GNUC__
> -#    define YYSTACK_ALLOC __builtin_alloca
> -#   elif defined __BUILTIN_VA_ARG_INCR
> -#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
> -#   elif defined _AIX
> -#    define YYSTACK_ALLOC __alloca
> -#   elif defined _MSC_VER
> -#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
> -#    define alloca _alloca
> -#   else
> -#    define YYSTACK_ALLOC alloca
> -#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
> -#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
> -      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
> -#     ifndef EXIT_SUCCESS
> -#      define EXIT_SUCCESS 0
> -#     endif
> -#    endif
> -#   endif
> -#  endif
> -# endif
> -
> -# ifdef YYSTACK_ALLOC
> -   /* Pacify GCC's 'empty if-body' warning.  */
> -#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
> -#  ifndef YYSTACK_ALLOC_MAXIMUM
> -    /* The OS might guarantee only one guard page at the bottom of the stack,
> -       and a page size can be as small as 4096 bytes.  So we cannot safely
> -       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
> -       to allow for a few compiler-allocated temporary stack slots.  */
> -#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
> -#  endif
> -# else
> -#  define YYSTACK_ALLOC YYMALLOC
> -#  define YYSTACK_FREE YYFREE
> -#  ifndef YYSTACK_ALLOC_MAXIMUM
> -#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
> -#  endif
> -#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
> -       && ! ((defined YYMALLOC || defined malloc) \
> -             && (defined YYFREE || defined free)))
> -#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
> -#   ifndef EXIT_SUCCESS
> -#    define EXIT_SUCCESS 0
> -#   endif
> -#  endif
> -#  ifndef YYMALLOC
> -#   define YYMALLOC malloc
> -#   if ! defined malloc && ! defined EXIT_SUCCESS
> -void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
> -#   endif
> -#  endif
> -#  ifndef YYFREE
> -#   define YYFREE free
> -#   if ! defined free && ! defined EXIT_SUCCESS
> -void free (void *); /* INFRINGES ON USER NAME SPACE */
> -#   endif
> -#  endif
> -# endif
> -#endif /* ! defined yyoverflow || YYERROR_VERBOSE */
> -
> -
> -#if (! defined yyoverflow \
> -     && (! defined __cplusplus \
> -         || (defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL \
> -             && defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))
> -
> -/* A type that is properly aligned for any stack member.  */
> -union yyalloc
> -{
> -  yytype_int16 yyss_alloc;
> -  YYSTYPE yyvs_alloc;
> -  YYLTYPE yyls_alloc;
> -};
> -
> -/* The size of the maximum gap between one aligned stack and the next.  */
> -# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)
> -
> -/* The size of an array large to enough to hold all stacks, each with
> -   N elements.  */
> -# define YYSTACK_BYTES(N) \
> -     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE) + sizeof (YYLTYPE)) \
> -      + 2 * YYSTACK_GAP_MAXIMUM)
> -
> -# define YYCOPY_NEEDED 1
> -
> -/* Relocate STACK from its old location to the new one.  The
> -   local variables YYSIZE and YYSTACKSIZE give the old and new number of
> -   elements in the stack, and YYPTR gives the new location of the
> -   stack.  Advance YYPTR to a properly aligned location for the next
> -   stack.  */
> -# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
> -    do                                                                  \
> -      {                                                                 \
> -        YYSIZE_T yynewbytes;                                            \
> -        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
> -        Stack = &yyptr->Stack_alloc;                                    \
> -        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
> -        yyptr += yynewbytes / sizeof (*yyptr);                          \
> -      }                                                                 \
> -    while (0)
> -
> -#endif
> -
> -#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
> -/* Copy COUNT objects from SRC to DST.  The source and destination do
> -   not overlap.  */
> -# ifndef YYCOPY
> -#  if defined __GNUC__ && 1 < __GNUC__
> -#   define YYCOPY(Dst, Src, Count) \
> -      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
> -#  else
> -#   define YYCOPY(Dst, Src, Count)              \
> -      do                                        \
> -        {                                       \
> -          YYSIZE_T yyi;                         \
> -          for (yyi = 0; yyi < (Count); yyi++)   \
> -            (Dst)[yyi] = (Src)[yyi];            \
> -        }                                       \
> -      while (0)
> -#  endif
> -# endif
> -#endif /* !YYCOPY_NEEDED */
> -
> -/* YYFINAL -- State number of the termination state.  */
> -#define YYFINAL  6
> -/* YYLAST -- Last index in YYTABLE.  */
> -#define YYLAST   138
> -
> -/* YYNTOKENS -- Number of terminals.  */
> -#define YYNTOKENS  48
> -/* YYNNTS -- Number of nonterminals.  */
> -#define YYNNTS  30
> -/* YYNRULES -- Number of rules.  */
> -#define YYNRULES  85
> -/* YYNSTATES -- Number of states.  */
> -#define YYNSTATES  149
> -
> -/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
> -   by yylex, with out-of-bounds checking.  */
> -#define YYUNDEFTOK  2
> -#define YYMAXUTOK   279
> -
> -#define YYTRANSLATE(YYX)                                                \
> -  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)
> -
> -/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
> -   as returned by yylex, without out-of-bounds checking.  */
> -static const yytype_uint8 yytranslate[] =
> -{
> -       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,    47,     2,     2,     2,    45,    41,     2,
> -      33,    35,    44,    42,    34,    43,     2,    26,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,    38,    25,
> -      36,    29,    30,    37,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,    31,     2,    32,    40,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,    27,    39,    28,    46,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
> -       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
> -      15,    16,    17,    18,    19,    20,    21,    22,    23,    24
> -};
> -
> -#if YYDEBUG
> -  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
> -static const yytype_uint16 yyrline[] =
> -{
> -       0,   109,   109,   117,   121,   128,   129,   139,   142,   149,
> -     153,   161,   165,   170,   181,   200,   213,   220,   228,   231,
> -     238,   242,   246,   250,   258,   262,   266,   270,   274,   290,
> -     300,   308,   311,   315,   322,   338,   343,   362,   376,   383,
> -     384,   385,   392,   396,   397,   401,   402,   406,   407,   411,
> -     412,   416,   417,   421,   422,   426,   427,   428,   432,   433,
> -     434,   435,   436,   440,   441,   442,   446,   447,   448,   452,
> -     453,   462,   471,   475,   476,   477,   478,   483,   486,   490,
> -     498,   501,   505,   513,   517,   521
> -};
> -#endif
> -
> -#if YYDEBUG || YYERROR_VERBOSE || 0
> -/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
> -   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
> -static const char *const yytname[] =
> -{
> -  "$end", "error", "$undefined", "DT_V1", "DT_PLUGIN", "DT_MEMRESERVE",
> -  "DT_LSHIFT", "DT_RSHIFT", "DT_LE", "DT_GE", "DT_EQ", "DT_NE", "DT_AND",
> -  "DT_OR", "DT_BITS", "DT_DEL_PROP", "DT_DEL_NODE", "DT_PROPNODENAME",
> -  "DT_LITERAL", "DT_CHAR_LITERAL", "DT_BYTE", "DT_STRING", "DT_LABEL",
> -  "DT_REF", "DT_INCBIN", "';'", "'/'", "'{'", "'}'", "'='", "'>'", "'['",
> -  "']'", "'('", "','", "')'", "'<'", "'?'", "':'", "'|'", "'^'", "'&'",
> -  "'+'", "'-'", "'*'", "'%'", "'~'", "'!'", "$accept", "sourcefile",
> -  "header", "headers", "memreserves", "memreserve", "devicetree",
> -  "nodedef", "proplist", "propdef", "propdata", "propdataprefix",
> -  "arrayprefix", "integer_prim", "integer_expr", "integer_trinary",
> -  "integer_or", "integer_and", "integer_bitor", "integer_bitxor",
> -  "integer_bitand", "integer_eq", "integer_rela", "integer_shift",
> -  "integer_add", "integer_mul", "integer_unary", "bytestring", "subnodes",
> -  "subnode", YY_NULLPTR
> -};
> -#endif
> -
> -# ifdef YYPRINT
> -/* YYTOKNUM[NUM] -- (External) token number corresponding to the
> -   (internal) symbol number NUM (which must be that of a token).  */
> -static const yytype_uint16 yytoknum[] =
> -{
> -       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
> -     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
> -     275,   276,   277,   278,   279,    59,    47,   123,   125,    61,
> -      62,    91,    93,    40,    44,    41,    60,    63,    58,   124,
> -      94,    38,    43,    45,    42,    37,   126,    33
> -};
> -# endif
> -
> -#define YYPACT_NINF -44
> -
> -#define yypact_value_is_default(Yystate) \
> -  (!!((Yystate) == (-44)))
> -
> -#define YYTABLE_NINF -1
> -
> -#define yytable_value_is_error(Yytable_value) \
> -  0
> -
> -  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
> -     STATE-NUM.  */
> -static const yytype_int8 yypact[] =
> -{
> -      14,    27,    61,    14,     8,    18,   -44,   -44,    37,     8,
> -      40,     8,    64,   -44,   -44,   -12,    37,   -44,    50,    52,
> -     -44,   -44,   -12,   -12,   -12,   -44,    51,   -44,    -4,    78,
> -      53,    54,    55,    17,     2,    30,    38,    -3,   -44,    66,
> -     -44,   -44,    70,    72,    50,    50,   -44,   -44,   -44,   -44,
> -     -12,   -12,   -12,   -12,   -12,   -12,   -12,   -12,   -12,   -12,
> -     -12,   -12,   -12,   -12,   -12,   -12,   -12,   -12,   -12,   -44,
> -       3,    73,    50,   -44,   -44,    78,    59,    53,    54,    55,
> -      17,     2,     2,    30,    30,    30,    30,    38,    38,    -3,
> -      -3,   -44,   -44,   -44,    82,    83,    44,     3,   -44,    74,
> -       3,   -44,   -44,   -12,    76,    79,   -44,   -44,   -44,   -44,
> -     -44,    80,   -44,   -44,   -44,   -44,   -44,   -10,    36,   -44,
> -     -44,   -44,   -44,    85,   -44,   -44,   -44,    75,   -44,   -44,
> -      21,    71,    88,    -6,   -44,   -44,   -44,   -44,   -44,    11,
> -     -44,   -44,   -44,    37,   -44,    77,    37,    81,   -44
> -};
> -
> -  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
> -     Performed when YYTABLE does not specify something else to do.  Zero
> -     means the default is an error.  */
> -static const yytype_uint8 yydefact[] =
> -{
> -       0,     0,     0,     5,     7,     3,     1,     6,     0,     0,
> -      16,     7,     0,    39,    40,     0,     0,    10,     0,     2,
> -       8,     4,     0,     0,     0,    73,     0,    42,    43,    45,
> -      47,    49,    51,    53,    55,    58,    65,    68,    72,     0,
> -      18,    11,     0,     0,     0,     0,    74,    75,    76,    41,
> -       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
> -       0,     0,     0,     0,     0,     0,     0,     0,     0,     9,
> -      80,     0,     0,    14,    12,    46,     0,    48,    50,    52,
> -      54,    56,    57,    61,    62,    60,    59,    63,    64,    66,
> -      67,    70,    69,    71,     0,     0,     0,     0,    19,     0,
> -      80,    15,    13,     0,     0,     0,    21,    31,    83,    23,
> -      85,     0,    82,    81,    44,    22,    84,     0,     0,    17,
> -      30,    20,    32,     0,    24,    33,    27,     0,    77,    35,
> -       0,     0,     0,     0,    38,    37,    25,    36,    34,     0,
> -      78,    79,    26,     0,    29,     0,     0,     0,    28
> -};
> -
> -  /* YYPGOTO[NTERM-NUM].  */
> -static const yytype_int8 yypgoto[] =
> -{
> -     -44,   -44,   -44,   103,    99,   104,   -44,   -43,   -44,   -21,
> -     -44,   -44,   -44,    -8,    63,     9,   -44,    65,    67,    68,
> -      69,    62,    26,     4,    22,    23,   -19,   -44,    20,    28
> -};
> -
> -  /* YYDEFGOTO[NTERM-NUM].  */
> -static const yytype_int16 yydefgoto[] =
> -{
> -      -1,     2,     3,     4,    10,    11,    19,    41,    70,    98,
> -     117,   118,   130,    25,    26,    27,    28,    29,    30,    31,
> -      32,    33,    34,    35,    36,    37,    38,   133,    99,   100
> -};
> -
> -  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
> -     positive, shift that token.  If negative, reduce the rule whose
> -     number is the opposite.  If YYTABLE_NINF, syntax error.  */
> -static const yytype_uint8 yytable[] =
> -{
> -      16,    73,    74,    46,    47,    48,    13,    14,    39,    50,
> -      58,    59,   120,     8,   140,   121,   141,     1,    94,    95,
> -      96,    15,    12,    66,   122,    97,   142,    56,    57,   102,
> -       9,    22,    60,    51,    23,    24,    62,    63,    61,    13,
> -      14,    67,    68,   134,   135,   143,   144,    91,    92,    93,
> -     123,   136,     5,   108,    15,    13,    14,   124,   125,   126,
> -     127,     6,    83,    84,    85,    86,    18,   128,    42,   106,
> -      15,    40,   129,   107,    43,    44,   109,    40,    45,   112,
> -      64,    65,    81,    82,    87,    88,    49,    89,    90,    21,
> -      52,    69,    53,    71,    54,    72,    55,   103,   101,   104,
> -     105,   115,   111,   131,   116,   119,     7,   138,   132,   139,
> -      20,   146,   114,    17,    76,    75,   148,    80,     0,    77,
> -     113,    78,   137,    79,     0,   110,     0,     0,     0,     0,
> -       0,     0,     0,     0,     0,   145,     0,     0,   147
> -};
> -
> -static const yytype_int16 yycheck[] =
> -{
> -       8,    44,    45,    22,    23,    24,    18,    19,    16,    13,
> -       8,     9,    22,     5,    20,    25,    22,     3,    15,    16,
> -      17,    33,     4,    26,    34,    22,    32,    10,    11,    72,
> -      22,    43,    30,    37,    46,    47,     6,     7,    36,    18,
> -      19,    44,    45,    22,    23,    34,    35,    66,    67,    68,
> -      14,    30,    25,    96,    33,    18,    19,    21,    22,    23,
> -      24,     0,    58,    59,    60,    61,    26,    31,    16,    25,
> -      33,    27,    36,    29,    22,    23,    97,    27,    26,   100,
> -      42,    43,    56,    57,    62,    63,    35,    64,    65,    25,
> -      12,    25,    39,    23,    40,    23,    41,    38,    25,    17,
> -      17,    25,    28,    18,    25,    25,     3,    36,    33,    21,
> -      11,    34,   103,     9,    51,    50,    35,    55,    -1,    52,
> -     100,    53,   130,    54,    -1,    97,    -1,    -1,    -1,    -1,
> -      -1,    -1,    -1,    -1,    -1,   143,    -1,    -1,   146
> -};
> -
> -  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
> -     symbol of state STATE-NUM.  */
> -static const yytype_uint8 yystos[] =
> -{
> -       0,     3,    49,    50,    51,    25,     0,    51,     5,    22,
> -      52,    53,     4,    18,    19,    33,    61,    53,    26,    54,
> -      52,    25,    43,    46,    47,    61,    62,    63,    64,    65,
> -      66,    67,    68,    69,    70,    71,    72,    73,    74,    61,
> -      27,    55,    16,    22,    23,    26,    74,    74,    74,    35,
> -      13,    37,    12,    39,    40,    41,    10,    11,     8,     9,
> -      30,    36,     6,     7,    42,    43,    26,    44,    45,    25,
> -      56,    23,    23,    55,    55,    65,    62,    66,    67,    68,
> -      69,    70,    70,    71,    71,    71,    71,    72,    72,    73,
> -      73,    74,    74,    74,    15,    16,    17,    22,    57,    76,
> -      77,    25,    55,    38,    17,    17,    25,    29,    55,    57,
> -      77,    28,    57,    76,    63,    25,    25,    58,    59,    25,
> -      22,    25,    34,    14,    21,    22,    23,    24,    31,    36,
> -      60,    18,    33,    75,    22,    23,    30,    61,    36,    21,
> -      20,    22,    32,    34,    35,    61,    34,    61,    35
> -};
> -
> -  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
> -static const yytype_uint8 yyr1[] =
> -{
> -       0,    48,    49,    50,    50,    51,    51,    52,    52,    53,
> -      53,    54,    54,    54,    54,    54,    54,    55,    56,    56,
> -      57,    57,    57,    57,    58,    58,    58,    58,    58,    58,
> -      58,    59,    59,    59,    60,    60,    60,    60,    60,    61,
> -      61,    61,    62,    63,    63,    64,    64,    65,    65,    66,
> -      66,    67,    67,    68,    68,    69,    69,    69,    70,    70,
> -      70,    70,    70,    71,    71,    71,    72,    72,    72,    73,
> -      73,    73,    73,    74,    74,    74,    74,    75,    75,    75,
> -      76,    76,    76,    77,    77,    77
> -};
> -
> -  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
> -static const yytype_uint8 yyr2[] =
> -{
> -       0,     2,     3,     2,     4,     1,     2,     0,     2,     4,
> -       2,     2,     3,     4,     3,     4,     0,     5,     0,     2,
> -       4,     2,     3,     2,     2,     3,     4,     2,     9,     5,
> -       2,     0,     2,     2,     3,     1,     2,     2,     2,     1,
> -       1,     3,     1,     1,     5,     1,     3,     1,     3,     1,
> -       3,     1,     3,     1,     3,     1,     3,     3,     1,     3,
> -       3,     3,     3,     3,     3,     1,     3,     3,     1,     3,
> -       3,     3,     1,     1,     2,     2,     2,     0,     2,     2,
> -       0,     2,     2,     2,     3,     2
> -};
> -
> -
> -#define yyerrok         (yyerrstatus = 0)
> -#define yyclearin       (yychar = YYEMPTY)
> -#define YYEMPTY         (-2)
> -#define YYEOF           0
> -
> -#define YYACCEPT        goto yyacceptlab
> -#define YYABORT         goto yyabortlab
> -#define YYERROR         goto yyerrorlab
> -
> -
> -#define YYRECOVERING()  (!!yyerrstatus)
> -
> -#define YYBACKUP(Token, Value)                                  \
> -do                                                              \
> -  if (yychar == YYEMPTY)                                        \
> -    {                                                           \
> -      yychar = (Token);                                         \
> -      yylval = (Value);                                         \
> -      YYPOPSTACK (yylen);                                       \
> -      yystate = *yyssp;                                         \
> -      goto yybackup;                                            \
> -    }                                                           \
> -  else                                                          \
> -    {                                                           \
> -      yyerror (YY_("syntax error: cannot back up")); \
> -      YYERROR;                                                  \
> -    }                                                           \
> -while (0)
> -
> -/* Error token number */
> -#define YYTERROR        1
> -#define YYERRCODE       256
> -
> -
> -/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
> -   If N is 0, then set CURRENT to the empty location which ends
> -   the previous symbol: RHS[0] (always defined).  */
> -
> -#ifndef YYLLOC_DEFAULT
> -# define YYLLOC_DEFAULT(Current, Rhs, N)                                \
> -    do                                                                  \
> -      if (N)                                                            \
> -        {                                                               \
> -          (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;        \
> -          (Current).first_column = YYRHSLOC (Rhs, 1).first_column;      \
> -          (Current).last_line    = YYRHSLOC (Rhs, N).last_line;         \
> -          (Current).last_column  = YYRHSLOC (Rhs, N).last_column;       \
> -        }                                                               \
> -      else                                                              \
> -        {                                                               \
> -          (Current).first_line   = (Current).last_line   =              \
> -            YYRHSLOC (Rhs, 0).last_line;                                \
> -          (Current).first_column = (Current).last_column =              \
> -            YYRHSLOC (Rhs, 0).last_column;                              \
> -        }                                                               \
> -    while (0)
> -#endif
> -
> -#define YYRHSLOC(Rhs, K) ((Rhs)[K])
> -
> -
> -/* Enable debugging if requested.  */
> -#if YYDEBUG
> -
> -# ifndef YYFPRINTF
> -#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
> -#  define YYFPRINTF fprintf
> -# endif
> -
> -# define YYDPRINTF(Args)                        \
> -do {                                            \
> -  if (yydebug)                                  \
> -    YYFPRINTF Args;                             \
> -} while (0)
> -
> -
> -/* YY_LOCATION_PRINT -- Print the location on the stream.
> -   This macro was not mandated originally: define only if we know
> -   we won't break user code: when these are the locations we know.  */
> -
> -#ifndef YY_LOCATION_PRINT
> -# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
> -
> -/* Print *YYLOCP on YYO.  Private, do not rely on its existence. */
> -
> -YY_ATTRIBUTE_UNUSED
> -static unsigned
> -yy_location_print_ (FILE *yyo, YYLTYPE const * const yylocp)
> -{
> -  unsigned res = 0;
> -  int end_col = 0 != yylocp->last_column ? yylocp->last_column - 1 : 0;
> -  if (0 <= yylocp->first_line)
> -    {
> -      res += YYFPRINTF (yyo, "%d", yylocp->first_line);
> -      if (0 <= yylocp->first_column)
> -        res += YYFPRINTF (yyo, ".%d", yylocp->first_column);
> -    }
> -  if (0 <= yylocp->last_line)
> -    {
> -      if (yylocp->first_line < yylocp->last_line)
> -        {
> -          res += YYFPRINTF (yyo, "-%d", yylocp->last_line);
> -          if (0 <= end_col)
> -            res += YYFPRINTF (yyo, ".%d", end_col);
> -        }
> -      else if (0 <= end_col && yylocp->first_column < end_col)
> -        res += YYFPRINTF (yyo, "-%d", end_col);
> -    }
> -  return res;
> - }
> -
> -#  define YY_LOCATION_PRINT(File, Loc)          \
> -  yy_location_print_ (File, &(Loc))
> -
> -# else
> -#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
> -# endif
> -#endif
> -
> -
> -# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
> -do {                                                                      \
> -  if (yydebug)                                                            \
> -    {                                                                     \
> -      YYFPRINTF (stderr, "%s ", Title);                                   \
> -      yy_symbol_print (stderr,                                            \
> -                  Type, Value, Location); \
> -      YYFPRINTF (stderr, "\n");                                           \
> -    }                                                                     \
> -} while (0)
> -
> -
> -/*----------------------------------------.
> -| Print this symbol's value on YYOUTPUT.  |
> -`----------------------------------------*/
> -
> -static void
> -yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
> -{
> -  FILE *yyo = yyoutput;
> -  YYUSE (yyo);
> -  YYUSE (yylocationp);
> -  if (!yyvaluep)
> -    return;
> -# ifdef YYPRINT
> -  if (yytype < YYNTOKENS)
> -    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
> -# endif
> -  YYUSE (yytype);
> -}
> -
> -
> -/*--------------------------------.
> -| Print this symbol on YYOUTPUT.  |
> -`--------------------------------*/
> -
> -static void
> -yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
> -{
> -  YYFPRINTF (yyoutput, "%s %s (",
> -             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);
> -
> -  YY_LOCATION_PRINT (yyoutput, *yylocationp);
> -  YYFPRINTF (yyoutput, ": ");
> -  yy_symbol_value_print (yyoutput, yytype, yyvaluep, yylocationp);
> -  YYFPRINTF (yyoutput, ")");
> -}
> -
> -/*------------------------------------------------------------------.
> -| yy_stack_print -- Print the state stack from its BOTTOM up to its |
> -| TOP (included).                                                   |
> -`------------------------------------------------------------------*/
> -
> -static void
> -yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
> -{
> -  YYFPRINTF (stderr, "Stack now");
> -  for (; yybottom <= yytop; yybottom++)
> -    {
> -      int yybot = *yybottom;
> -      YYFPRINTF (stderr, " %d", yybot);
> -    }
> -  YYFPRINTF (stderr, "\n");
> -}
> -
> -# define YY_STACK_PRINT(Bottom, Top)                            \
> -do {                                                            \
> -  if (yydebug)                                                  \
> -    yy_stack_print ((Bottom), (Top));                           \
> -} while (0)
> -
> -
> -/*------------------------------------------------.
> -| Report that the YYRULE is going to be reduced.  |
> -`------------------------------------------------*/
> -
> -static void
> -yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, YYLTYPE *yylsp, int yyrule)
> -{
> -  unsigned long int yylno = yyrline[yyrule];
> -  int yynrhs = yyr2[yyrule];
> -  int yyi;
> -  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
> -             yyrule - 1, yylno);
> -  /* The symbols being reduced.  */
> -  for (yyi = 0; yyi < yynrhs; yyi++)
> -    {
> -      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
> -      yy_symbol_print (stderr,
> -                       yystos[yyssp[yyi + 1 - yynrhs]],
> -                       &(yyvsp[(yyi + 1) - (yynrhs)])
> -                       , &(yylsp[(yyi + 1) - (yynrhs)])                       );
> -      YYFPRINTF (stderr, "\n");
> -    }
> -}
> -
> -# define YY_REDUCE_PRINT(Rule)          \
> -do {                                    \
> -  if (yydebug)                          \
> -    yy_reduce_print (yyssp, yyvsp, yylsp, Rule); \
> -} while (0)
> -
> -/* Nonzero means print parse trace.  It is left uninitialized so that
> -   multiple parsers can coexist.  */
> -int yydebug;
> -#else /* !YYDEBUG */
> -# define YYDPRINTF(Args)
> -# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
> -# define YY_STACK_PRINT(Bottom, Top)
> -# define YY_REDUCE_PRINT(Rule)
> -#endif /* !YYDEBUG */
> -
> -
> -/* YYINITDEPTH -- initial size of the parser's stacks.  */
> -#ifndef YYINITDEPTH
> -# define YYINITDEPTH 200
> -#endif
> -
> -/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
> -   if the built-in stack extension method is used).
> -
> -   Do not make this value too large; the results are undefined if
> -   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
> -   evaluated with infinite-precision integer arithmetic.  */
> -
> -#ifndef YYMAXDEPTH
> -# define YYMAXDEPTH 10000
> -#endif
> -
> -
> -#if YYERROR_VERBOSE
> -
> -# ifndef yystrlen
> -#  if defined __GLIBC__ && defined _STRING_H
> -#   define yystrlen strlen
> -#  else
> -/* Return the length of YYSTR.  */
> -static YYSIZE_T
> -yystrlen (const char *yystr)
> -{
> -  YYSIZE_T yylen;
> -  for (yylen = 0; yystr[yylen]; yylen++)
> -    continue;
> -  return yylen;
> -}
> -#  endif
> -# endif
> -
> -# ifndef yystpcpy
> -#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
> -#   define yystpcpy stpcpy
> -#  else
> -/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
> -   YYDEST.  */
> -static char *
> -yystpcpy (char *yydest, const char *yysrc)
> -{
> -  char *yyd = yydest;
> -  const char *yys = yysrc;
> -
> -  while ((*yyd++ = *yys++) != '\0')
> -    continue;
> -
> -  return yyd - 1;
> -}
> -#  endif
> -# endif
> -
> -# ifndef yytnamerr
> -/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
> -   quotes and backslashes, so that it's suitable for yyerror.  The
> -   heuristic is that double-quoting is unnecessary unless the string
> -   contains an apostrophe, a comma, or backslash (other than
> -   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
> -   null, do not copy; instead, return the length of what the result
> -   would have been.  */
> -static YYSIZE_T
> -yytnamerr (char *yyres, const char *yystr)
> -{
> -  if (*yystr == '"')
> -    {
> -      YYSIZE_T yyn = 0;
> -      char const *yyp = yystr;
> -
> -      for (;;)
> -        switch (*++yyp)
> -          {
> -          case '\'':
> -          case ',':
> -            goto do_not_strip_quotes;
> -
> -          case '\\':
> -            if (*++yyp != '\\')
> -              goto do_not_strip_quotes;
> -            /* Fall through.  */
> -          default:
> -            if (yyres)
> -              yyres[yyn] = *yyp;
> -            yyn++;
> -            break;
> -
> -          case '"':
> -            if (yyres)
> -              yyres[yyn] = '\0';
> -            return yyn;
> -          }
> -    do_not_strip_quotes: ;
> -    }
> -
> -  if (! yyres)
> -    return yystrlen (yystr);
> -
> -  return yystpcpy (yyres, yystr) - yyres;
> -}
> -# endif
> -
> -/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
> -   about the unexpected token YYTOKEN for the state stack whose top is
> -   YYSSP.
> -
> -   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
> -   not large enough to hold the message.  In that case, also set
> -   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
> -   required number of bytes is too large to store.  */
> -static int
> -yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
> -                yytype_int16 *yyssp, int yytoken)
> -{
> -  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
> -  YYSIZE_T yysize = yysize0;
> -  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
> -  /* Internationalized format string. */
> -  const char *yyformat = YY_NULLPTR;
> -  /* Arguments of yyformat. */
> -  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
> -  /* Number of reported tokens (one for the "unexpected", one per
> -     "expected"). */
> -  int yycount = 0;
> -
> -  /* There are many possibilities here to consider:
> -     - If this state is a consistent state with a default action, then
> -       the only way this function was invoked is if the default action
> -       is an error action.  In that case, don't check for expected
> -       tokens because there are none.
> -     - The only way there can be no lookahead present (in yychar) is if
> -       this state is a consistent state with a default action.  Thus,
> -       detecting the absence of a lookahead is sufficient to determine
> -       that there is no unexpected or expected token to report.  In that
> -       case, just report a simple "syntax error".
> -     - Don't assume there isn't a lookahead just because this state is a
> -       consistent state with a default action.  There might have been a
> -       previous inconsistent state, consistent state with a non-default
> -       action, or user semantic action that manipulated yychar.
> -     - Of course, the expected token list depends on states to have
> -       correct lookahead information, and it depends on the parser not
> -       to perform extra reductions after fetching a lookahead from the
> -       scanner and before detecting a syntax error.  Thus, state merging
> -       (from LALR or IELR) and default reductions corrupt the expected
> -       token list.  However, the list is correct for canonical LR with
> -       one exception: it will still contain any token that will not be
> -       accepted due to an error action in a later state.
> -  */
> -  if (yytoken != YYEMPTY)
> -    {
> -      int yyn = yypact[*yyssp];
> -      yyarg[yycount++] = yytname[yytoken];
> -      if (!yypact_value_is_default (yyn))
> -        {
> -          /* Start YYX at -YYN if negative to avoid negative indexes in
> -             YYCHECK.  In other words, skip the first -YYN actions for
> -             this state because they are default actions.  */
> -          int yyxbegin = yyn < 0 ? -yyn : 0;
> -          /* Stay within bounds of both yycheck and yytname.  */
> -          int yychecklim = YYLAST - yyn + 1;
> -          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
> -          int yyx;
> -
> -          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
> -            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
> -                && !yytable_value_is_error (yytable[yyx + yyn]))
> -              {
> -                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
> -                  {
> -                    yycount = 1;
> -                    yysize = yysize0;
> -                    break;
> -                  }
> -                yyarg[yycount++] = yytname[yyx];
> -                {
> -                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
> -                  if (! (yysize <= yysize1
> -                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
> -                    return 2;
> -                  yysize = yysize1;
> -                }
> -              }
> -        }
> -    }
> -
> -  switch (yycount)
> -    {
> -# define YYCASE_(N, S)                      \
> -      case N:                               \
> -        yyformat = S;                       \
> -      break
> -      YYCASE_(0, YY_("syntax error"));
> -      YYCASE_(1, YY_("syntax error, unexpected %s"));
> -      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
> -      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
> -      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
> -      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
> -# undef YYCASE_
> -    }
> -
> -  {
> -    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
> -    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
> -      return 2;
> -    yysize = yysize1;
> -  }
> -
> -  if (*yymsg_alloc < yysize)
> -    {
> -      *yymsg_alloc = 2 * yysize;
> -      if (! (yysize <= *yymsg_alloc
> -             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
> -        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
> -      return 1;
> -    }
> -
> -  /* Avoid sprintf, as that infringes on the user's name space.
> -     Don't have undefined behavior even if the translation
> -     produced a string with the wrong number of "%s"s.  */
> -  {
> -    char *yyp = *yymsg;
> -    int yyi = 0;
> -    while ((*yyp = *yyformat) != '\0')
> -      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
> -        {
> -          yyp += yytnamerr (yyp, yyarg[yyi++]);
> -          yyformat += 2;
> -        }
> -      else
> -        {
> -          yyp++;
> -          yyformat++;
> -        }
> -  }
> -  return 0;
> -}
> -#endif /* YYERROR_VERBOSE */
> -
> -/*-----------------------------------------------.
> -| Release the memory associated to this symbol.  |
> -`-----------------------------------------------*/
> -
> -static void
> -yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep, YYLTYPE *yylocationp)
> -{
> -  YYUSE (yyvaluep);
> -  YYUSE (yylocationp);
> -  if (!yymsg)
> -    yymsg = "Deleting";
> -  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);
> -
> -  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
> -  YYUSE (yytype);
> -  YY_IGNORE_MAYBE_UNINITIALIZED_END
> -}
> -
> -
> -
> -
> -/* The lookahead symbol.  */
> -int yychar;
> -
> -/* The semantic value of the lookahead symbol.  */
> -YYSTYPE yylval;
> -/* Location data for the lookahead symbol.  */
> -YYLTYPE yylloc
> -# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
> -  = { 1, 1, 1, 1 }
> -# endif
> -;
> -/* Number of syntax errors so far.  */
> -int yynerrs;
> -
> -
> -/*----------.
> -| yyparse.  |
> -`----------*/
> -
> -int
> -yyparse (void)
> -{
> -    int yystate;
> -    /* Number of tokens to shift before error messages enabled.  */
> -    int yyerrstatus;
> -
> -    /* The stacks and their tools:
> -       'yyss': related to states.
> -       'yyvs': related to semantic values.
> -       'yyls': related to locations.
> -
> -       Refer to the stacks through separate pointers, to allow yyoverflow
> -       to reallocate them elsewhere.  */
> -
> -    /* The state stack.  */
> -    yytype_int16 yyssa[YYINITDEPTH];
> -    yytype_int16 *yyss;
> -    yytype_int16 *yyssp;
> -
> -    /* The semantic value stack.  */
> -    YYSTYPE yyvsa[YYINITDEPTH];
> -    YYSTYPE *yyvs;
> -    YYSTYPE *yyvsp;
> -
> -    /* The location stack.  */
> -    YYLTYPE yylsa[YYINITDEPTH];
> -    YYLTYPE *yyls;
> -    YYLTYPE *yylsp;
> -
> -    /* The locations where the error started and ended.  */
> -    YYLTYPE yyerror_range[3];
> -
> -    YYSIZE_T yystacksize;
> -
> -  int yyn;
> -  int yyresult;
> -  /* Lookahead token as an internal (translated) token number.  */
> -  int yytoken = 0;
> -  /* The variables used to return semantic value and location from the
> -     action routines.  */
> -  YYSTYPE yyval;
> -  YYLTYPE yyloc;
> -
> -#if YYERROR_VERBOSE
> -  /* Buffer for error messages, and its allocated size.  */
> -  char yymsgbuf[128];
> -  char *yymsg = yymsgbuf;
> -  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
> -#endif
> -
> -#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N), yylsp -= (N))
> -
> -  /* The number of symbols on the RHS of the reduced rule.
> -     Keep to zero when no symbol should be popped.  */
> -  int yylen = 0;
> -
> -  yyssp = yyss = yyssa;
> -  yyvsp = yyvs = yyvsa;
> -  yylsp = yyls = yylsa;
> -  yystacksize = YYINITDEPTH;
> -
> -  YYDPRINTF ((stderr, "Starting parse\n"));
> -
> -  yystate = 0;
> -  yyerrstatus = 0;
> -  yynerrs = 0;
> -  yychar = YYEMPTY; /* Cause a token to be read.  */
> -  yylsp[0] = yylloc;
> -  goto yysetstate;
> -
> -/*------------------------------------------------------------.
> -| yynewstate -- Push a new state, which is found in yystate.  |
> -`------------------------------------------------------------*/
> - yynewstate:
> -  /* In all cases, when you get here, the value and location stacks
> -     have just been pushed.  So pushing a state here evens the stacks.  */
> -  yyssp++;
> -
> - yysetstate:
> -  *yyssp = yystate;
> -
> -  if (yyss + yystacksize - 1 <= yyssp)
> -    {
> -      /* Get the current used size of the three stacks, in elements.  */
> -      YYSIZE_T yysize = yyssp - yyss + 1;
> -
> -#ifdef yyoverflow
> -      {
> -        /* Give user a chance to reallocate the stack.  Use copies of
> -           these so that the &'s don't force the real ones into
> -           memory.  */
> -        YYSTYPE *yyvs1 = yyvs;
> -        yytype_int16 *yyss1 = yyss;
> -        YYLTYPE *yyls1 = yyls;
> -
> -        /* Each stack pointer address is followed by the size of the
> -           data in use in that stack, in bytes.  This used to be a
> -           conditional around just the two extra args, but that might
> -           be undefined if yyoverflow is a macro.  */
> -        yyoverflow (YY_("memory exhausted"),
> -                    &yyss1, yysize * sizeof (*yyssp),
> -                    &yyvs1, yysize * sizeof (*yyvsp),
> -                    &yyls1, yysize * sizeof (*yylsp),
> -                    &yystacksize);
> -
> -        yyls = yyls1;
> -        yyss = yyss1;
> -        yyvs = yyvs1;
> -      }
> -#else /* no yyoverflow */
> -# ifndef YYSTACK_RELOCATE
> -      goto yyexhaustedlab;
> -# else
> -      /* Extend the stack our own way.  */
> -      if (YYMAXDEPTH <= yystacksize)
> -        goto yyexhaustedlab;
> -      yystacksize *= 2;
> -      if (YYMAXDEPTH < yystacksize)
> -        yystacksize = YYMAXDEPTH;
> -
> -      {
> -        yytype_int16 *yyss1 = yyss;
> -        union yyalloc *yyptr =
> -          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
> -        if (! yyptr)
> -          goto yyexhaustedlab;
> -        YYSTACK_RELOCATE (yyss_alloc, yyss);
> -        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
> -        YYSTACK_RELOCATE (yyls_alloc, yyls);
> -#  undef YYSTACK_RELOCATE
> -        if (yyss1 != yyssa)
> -          YYSTACK_FREE (yyss1);
> -      }
> -# endif
> -#endif /* no yyoverflow */
> -
> -      yyssp = yyss + yysize - 1;
> -      yyvsp = yyvs + yysize - 1;
> -      yylsp = yyls + yysize - 1;
> -
> -      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
> -                  (unsigned long int) yystacksize));
> -
> -      if (yyss + yystacksize - 1 <= yyssp)
> -        YYABORT;
> -    }
> -
> -  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
> -
> -  if (yystate == YYFINAL)
> -    YYACCEPT;
> -
> -  goto yybackup;
> -
> -/*-----------.
> -| yybackup.  |
> -`-----------*/
> -yybackup:
> -
> -  /* Do appropriate processing given the current state.  Read a
> -     lookahead token if we need one and don't already have one.  */
> -
> -  /* First try to decide what to do without reference to lookahead token.  */
> -  yyn = yypact[yystate];
> -  if (yypact_value_is_default (yyn))
> -    goto yydefault;
> -
> -  /* Not known => get a lookahead token if don't already have one.  */
> -
> -  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
> -  if (yychar == YYEMPTY)
> -    {
> -      YYDPRINTF ((stderr, "Reading a token: "));
> -      yychar = yylex ();
> -    }
> -
> -  if (yychar <= YYEOF)
> -    {
> -      yychar = yytoken = YYEOF;
> -      YYDPRINTF ((stderr, "Now at end of input.\n"));
> -    }
> -  else
> -    {
> -      yytoken = YYTRANSLATE (yychar);
> -      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
> -    }
> -
> -  /* If the proper action on seeing token YYTOKEN is to reduce or to
> -     detect an error, take that action.  */
> -  yyn += yytoken;
> -  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
> -    goto yydefault;
> -  yyn = yytable[yyn];
> -  if (yyn <= 0)
> -    {
> -      if (yytable_value_is_error (yyn))
> -        goto yyerrlab;
> -      yyn = -yyn;
> -      goto yyreduce;
> -    }
> -
> -  /* Count tokens shifted since error; after three, turn off error
> -     status.  */
> -  if (yyerrstatus)
> -    yyerrstatus--;
> -
> -  /* Shift the lookahead token.  */
> -  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
> -
> -  /* Discard the shifted token.  */
> -  yychar = YYEMPTY;
> -
> -  yystate = yyn;
> -  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
> -  *++yyvsp = yylval;
> -  YY_IGNORE_MAYBE_UNINITIALIZED_END
> -  *++yylsp = yylloc;
> -  goto yynewstate;
> -
> -
> -/*-----------------------------------------------------------.
> -| yydefault -- do the default action for the current state.  |
> -`-----------------------------------------------------------*/
> -yydefault:
> -  yyn = yydefact[yystate];
> -  if (yyn == 0)
> -    goto yyerrlab;
> -  goto yyreduce;
> -
> -
> -/*-----------------------------.
> -| yyreduce -- Do a reduction.  |
> -`-----------------------------*/
> -yyreduce:
> -  /* yyn is the number of a rule to reduce with.  */
> -  yylen = yyr2[yyn];
> -
> -  /* If YYLEN is nonzero, implement the default value of the action:
> -     '$$ = $1'.
> -
> -     Otherwise, the following line sets YYVAL to garbage.
> -     This behavior is undocumented and Bison
> -     users should not rely upon it.  Assigning to YYVAL
> -     unconditionally makes the parser a bit smaller, and it avoids a
> -     GCC warning that YYVAL may be used uninitialized.  */
> -  yyval = yyvsp[1-yylen];
> -
> -  /* Default location.  */
> -  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);
> -  YY_REDUCE_PRINT (yyn);
> -  switch (yyn)
> -    {
> -        case 2:
> -#line 110 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       parser_output = build_dt_info((yyvsp[-2].flags), (yyvsp[-1].re), (yyvsp[0].node),
> -                                                     guess_boot_cpuid((yyvsp[0].node)));
> -               }
> -#line 1478 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 3:
> -#line 118 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.flags) = DTSF_V1;
> -               }
> -#line 1486 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 4:
> -#line 122 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.flags) = DTSF_V1 | DTSF_PLUGIN;
> -               }
> -#line 1494 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 6:
> -#line 130 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       if ((yyvsp[0].flags) != (yyvsp[-1].flags))
> -                               ERROR(&(yylsp[0]), "Header flags don't match earlier ones");
> -                       (yyval.flags) = (yyvsp[-1].flags);
> -               }
> -#line 1504 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 7:
> -#line 139 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.re) = NULL;
> -               }
> -#line 1512 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 8:
> -#line 143 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.re) = chain_reserve_entry((yyvsp[-1].re), (yyvsp[0].re));
> -               }
> -#line 1520 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 9:
> -#line 150 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.re) = build_reserve_entry((yyvsp[-2].integer), (yyvsp[-1].integer));
> -               }
> -#line 1528 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 10:
> -#line 154 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       add_label(&(yyvsp[0].re)->labels, (yyvsp[-1].labelref));
> -                       (yyval.re) = (yyvsp[0].re);
> -               }
> -#line 1537 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 11:
> -#line 162 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.node) = name_node((yyvsp[0].node), "");
> -               }
> -#line 1545 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 12:
> -#line 166 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.node) = merge_nodes((yyvsp[-2].node), (yyvsp[0].node));
> -               }
> -#line 1553 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 13:
> -#line 171 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       struct node *target = get_node_by_ref((yyvsp[-3].node), (yyvsp[-1].labelref));
> -
> -                       if (target) {
> -                               add_label(&target->labels, (yyvsp[-2].labelref));
> -                               merge_nodes(target, (yyvsp[0].node));
> -                       } else
> -                               ERROR(&(yylsp[-1]), "Label or path %s not found", (yyvsp[-1].labelref));
> -                       (yyval.node) = (yyvsp[-3].node);
> -               }
> -#line 1568 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 14:
> -#line 182 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       struct node *target = get_node_by_ref((yyvsp[-2].node), (yyvsp[-1].labelref));
> -
> -                       if (target) {
> -                               merge_nodes(target, (yyvsp[0].node));
> -                       } else {
> -                               /*
> -                                * We rely on the rule being always:
> -                                *   versioninfo plugindecl memreserves devicetree
> -                                * so $-1 is what we want (plugindecl)
> -                                */
> -                               if ((yyvsp[(-1) - (3)].flags) & DTSF_PLUGIN)
> -                                       add_orphan_node((yyvsp[-2].node), (yyvsp[0].node), (yyvsp[-1].labelref));
> -                               else
> -                                       ERROR(&(yylsp[-1]), "Label or path %s not found", (yyvsp[-1].labelref));
> -                       }
> -                       (yyval.node) = (yyvsp[-2].node);
> -               }
> -#line 1591 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 15:
> -#line 201 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       struct node *target = get_node_by_ref((yyvsp[-3].node), (yyvsp[-1].labelref));
> -
> -                       if (target)
> -                               delete_node(target);
> -                       else
> -                               ERROR(&(yylsp[-1]), "Label or path %s not found", (yyvsp[-1].labelref));
> -
> -
> -                       (yyval.node) = (yyvsp[-3].node);
> -               }
> -#line 1607 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 16:
> -#line 213 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       /* build empty node */
> -                       (yyval.node) = name_node(build_node(NULL, NULL), "");
> -               }
> -#line 1616 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 17:
> -#line 221 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.node) = build_node((yyvsp[-3].proplist), (yyvsp[-2].nodelist));
> -               }
> -#line 1624 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 18:
> -#line 228 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.proplist) = NULL;
> -               }
> -#line 1632 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 19:
> -#line 232 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.proplist) = chain_property((yyvsp[0].prop), (yyvsp[-1].proplist));
> -               }
> -#line 1640 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 20:
> -#line 239 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.prop) = build_property((yyvsp[-3].propnodename), (yyvsp[-1].data));
> -               }
> -#line 1648 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 21:
> -#line 243 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.prop) = build_property((yyvsp[-1].propnodename), empty_data);
> -               }
> -#line 1656 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 22:
> -#line 247 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.prop) = build_property_delete((yyvsp[-1].propnodename));
> -               }
> -#line 1664 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 23:
> -#line 251 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       add_label(&(yyvsp[0].prop)->labels, (yyvsp[-1].labelref));
> -                       (yyval.prop) = (yyvsp[0].prop);
> -               }
> -#line 1673 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 24:
> -#line 259 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.data) = data_merge((yyvsp[-1].data), (yyvsp[0].data));
> -               }
> -#line 1681 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 25:
> -#line 263 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.data) = data_merge((yyvsp[-2].data), (yyvsp[-1].array).data);
> -               }
> -#line 1689 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 26:
> -#line 267 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.data) = data_merge((yyvsp[-3].data), (yyvsp[-1].data));
> -               }
> -#line 1697 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 27:
> -#line 271 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.data) = data_add_marker((yyvsp[-1].data), REF_PATH, (yyvsp[0].labelref));
> -               }
> -#line 1705 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 28:
> -#line 275 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       FILE *f = srcfile_relative_open((yyvsp[-5].data).val, NULL);
> -                       struct data d;
> -
> -                       if ((yyvsp[-3].integer) != 0)
> -                               if (fseek(f, (yyvsp[-3].integer), SEEK_SET) != 0)
> -                                       die("Couldn't seek to offset %llu in \"%s\": %s",
> -                                           (unsigned long long)(yyvsp[-3].integer), (yyvsp[-5].data).val,
> -                                           strerror(errno));
> -
> -                       d = data_copy_file(f, (yyvsp[-1].integer));
> -
> -                       (yyval.data) = data_merge((yyvsp[-8].data), d);
> -                       fclose(f);
> -               }
> -#line 1725 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 29:
> -#line 291 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       FILE *f = srcfile_relative_open((yyvsp[-1].data).val, NULL);
> -                       struct data d = empty_data;
> -
> -                       d = data_copy_file(f, -1);
> -
> -                       (yyval.data) = data_merge((yyvsp[-4].data), d);
> -                       fclose(f);
> -               }
> -#line 1739 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 30:
> -#line 301 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.data) = data_add_marker((yyvsp[-1].data), LABEL, (yyvsp[0].labelref));
> -               }
> -#line 1747 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 31:
> -#line 308 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.data) = empty_data;
> -               }
> -#line 1755 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 32:
> -#line 312 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.data) = (yyvsp[-1].data);
> -               }
> -#line 1763 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 33:
> -#line 316 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.data) = data_add_marker((yyvsp[-1].data), LABEL, (yyvsp[0].labelref));
> -               }
> -#line 1771 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 34:
> -#line 323 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       unsigned long long bits;
> -
> -                       bits = (yyvsp[-1].integer);
> -
> -                       if ((bits !=  8) && (bits != 16) &&
> -                           (bits != 32) && (bits != 64)) {
> -                               ERROR(&(yylsp[-1]), "Array elements must be"
> -                                     " 8, 16, 32 or 64-bits");
> -                               bits = 32;
> -                       }
> -
> -                       (yyval.array).data = empty_data;
> -                       (yyval.array).bits = bits;
> -               }
> -#line 1791 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 35:
> -#line 339 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.array).data = empty_data;
> -                       (yyval.array).bits = 32;
> -               }
> -#line 1800 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 36:
> -#line 344 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       if ((yyvsp[-1].array).bits < 64) {
> -                               uint64_t mask = (1ULL << (yyvsp[-1].array).bits) - 1;
> -                               /*
> -                                * Bits above mask must either be all zero
> -                                * (positive within range of mask) or all one
> -                                * (negative and sign-extended). The second
> -                                * condition is true if when we set all bits
> -                                * within the mask to one (i.e. | in the
> -                                * mask), all bits are one.
> -                                */
> -                               if (((yyvsp[0].integer) > mask) && (((yyvsp[0].integer) | mask) != -1ULL))
> -                                       ERROR(&(yylsp[0]), "Value out of range for"
> -                                             " %d-bit array element", (yyvsp[-1].array).bits);
> -                       }
> -
> -                       (yyval.array).data = data_append_integer((yyvsp[-1].array).data, (yyvsp[0].integer), (yyvsp[-1].array).bits);
> -               }
> -#line 1823 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 37:
> -#line 363 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       uint64_t val = ~0ULL >> (64 - (yyvsp[-1].array).bits);
> -
> -                       if ((yyvsp[-1].array).bits == 32)
> -                               (yyvsp[-1].array).data = data_add_marker((yyvsp[-1].array).data,
> -                                                         REF_PHANDLE,
> -                                                         (yyvsp[0].labelref));
> -                       else
> -                               ERROR(&(yylsp[0]), "References are only allowed in "
> -                                           "arrays with 32-bit elements.");
> -
> -                       (yyval.array).data = data_append_integer((yyvsp[-1].array).data, val, (yyvsp[-1].array).bits);
> -               }
> -#line 1841 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 38:
> -#line 377 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.array).data = data_add_marker((yyvsp[-1].array).data, LABEL, (yyvsp[0].labelref));
> -               }
> -#line 1849 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 41:
> -#line 386 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.integer) = (yyvsp[-1].integer);
> -               }
> -#line 1857 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 44:
> -#line 397 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-4].integer) ? (yyvsp[-2].integer) : (yyvsp[0].integer); }
> -#line 1863 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 46:
> -#line 402 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) || (yyvsp[0].integer); }
> -#line 1869 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 48:
> -#line 407 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) && (yyvsp[0].integer); }
> -#line 1875 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 50:
> -#line 412 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) | (yyvsp[0].integer); }
> -#line 1881 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 52:
> -#line 417 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) ^ (yyvsp[0].integer); }
> -#line 1887 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 54:
> -#line 422 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) & (yyvsp[0].integer); }
> -#line 1893 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 56:
> -#line 427 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) == (yyvsp[0].integer); }
> -#line 1899 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 57:
> -#line 428 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) != (yyvsp[0].integer); }
> -#line 1905 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 59:
> -#line 433 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) < (yyvsp[0].integer); }
> -#line 1911 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 60:
> -#line 434 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) > (yyvsp[0].integer); }
> -#line 1917 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 61:
> -#line 435 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) <= (yyvsp[0].integer); }
> -#line 1923 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 62:
> -#line 436 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) >= (yyvsp[0].integer); }
> -#line 1929 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 63:
> -#line 440 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) << (yyvsp[0].integer); }
> -#line 1935 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 64:
> -#line 441 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) >> (yyvsp[0].integer); }
> -#line 1941 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 66:
> -#line 446 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) + (yyvsp[0].integer); }
> -#line 1947 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 67:
> -#line 447 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) - (yyvsp[0].integer); }
> -#line 1953 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 69:
> -#line 452 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = (yyvsp[-2].integer) * (yyvsp[0].integer); }
> -#line 1959 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 70:
> -#line 454 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       if ((yyvsp[0].integer) != 0) {
> -                               (yyval.integer) = (yyvsp[-2].integer) / (yyvsp[0].integer);
> -                       } else {
> -                               ERROR(&(yyloc), "Division by zero");
> -                               (yyval.integer) = 0;
> -                       }
> -               }
> -#line 1972 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 71:
> -#line 463 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       if ((yyvsp[0].integer) != 0) {
> -                               (yyval.integer) = (yyvsp[-2].integer) % (yyvsp[0].integer);
> -                       } else {
> -                               ERROR(&(yyloc), "Division by zero");
> -                               (yyval.integer) = 0;
> -                       }
> -               }
> -#line 1985 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 74:
> -#line 476 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = -(yyvsp[0].integer); }
> -#line 1991 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 75:
> -#line 477 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = ~(yyvsp[0].integer); }
> -#line 1997 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 76:
> -#line 478 "dtc-parser.y" /* yacc.c:1646  */
> -    { (yyval.integer) = !(yyvsp[0].integer); }
> -#line 2003 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 77:
> -#line 483 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.data) = empty_data;
> -               }
> -#line 2011 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 78:
> -#line 487 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.data) = data_append_byte((yyvsp[-1].data), (yyvsp[0].byte));
> -               }
> -#line 2019 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 79:
> -#line 491 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.data) = data_add_marker((yyvsp[-1].data), LABEL, (yyvsp[0].labelref));
> -               }
> -#line 2027 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 80:
> -#line 498 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.nodelist) = NULL;
> -               }
> -#line 2035 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 81:
> -#line 502 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.nodelist) = chain_node((yyvsp[-1].node), (yyvsp[0].nodelist));
> -               }
> -#line 2043 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 82:
> -#line 506 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       ERROR(&(yylsp[0]), "Properties must precede subnodes");
> -                       YYERROR;
> -               }
> -#line 2052 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 83:
> -#line 514 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.node) = name_node((yyvsp[0].node), (yyvsp[-1].propnodename));
> -               }
> -#line 2060 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 84:
> -#line 518 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       (yyval.node) = name_node(build_node_delete(), (yyvsp[-1].propnodename));
> -               }
> -#line 2068 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -  case 85:
> -#line 522 "dtc-parser.y" /* yacc.c:1646  */
> -    {
> -                       add_label(&(yyvsp[0].node)->labels, (yyvsp[-1].labelref));
> -                       (yyval.node) = (yyvsp[0].node);
> -               }
> -#line 2077 "dtc-parser.tab.c" /* yacc.c:1646  */
> -    break;
> -
> -
> -#line 2081 "dtc-parser.tab.c" /* yacc.c:1646  */
> -      default: break;
> -    }
> -  /* User semantic actions sometimes alter yychar, and that requires
> -     that yytoken be updated with the new translation.  We take the
> -     approach of translating immediately before every use of yytoken.
> -     One alternative is translating here after every semantic action,
> -     but that translation would be missed if the semantic action invokes
> -     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
> -     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
> -     incorrect destructor might then be invoked immediately.  In the
> -     case of YYERROR or YYBACKUP, subsequent parser actions might lead
> -     to an incorrect destructor call or verbose syntax error message
> -     before the lookahead is translated.  */
> -  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);
> -
> -  YYPOPSTACK (yylen);
> -  yylen = 0;
> -  YY_STACK_PRINT (yyss, yyssp);
> -
> -  *++yyvsp = yyval;
> -  *++yylsp = yyloc;
> -
> -  /* Now 'shift' the result of the reduction.  Determine what state
> -     that goes to, based on the state we popped back to and the rule
> -     number reduced by.  */
> -
> -  yyn = yyr1[yyn];
> -
> -  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
> -  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
> -    yystate = yytable[yystate];
> -  else
> -    yystate = yydefgoto[yyn - YYNTOKENS];
> -
> -  goto yynewstate;
> -
> -
> -/*--------------------------------------.
> -| yyerrlab -- here on detecting error.  |
> -`--------------------------------------*/
> -yyerrlab:
> -  /* Make sure we have latest lookahead translation.  See comments at
> -     user semantic actions for why this is necessary.  */
> -  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);
> -
> -  /* If not already recovering from an error, report this error.  */
> -  if (!yyerrstatus)
> -    {
> -      ++yynerrs;
> -#if ! YYERROR_VERBOSE
> -      yyerror (YY_("syntax error"));
> -#else
> -# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
> -                                        yyssp, yytoken)
> -      {
> -        char const *yymsgp = YY_("syntax error");
> -        int yysyntax_error_status;
> -        yysyntax_error_status = YYSYNTAX_ERROR;
> -        if (yysyntax_error_status == 0)
> -          yymsgp = yymsg;
> -        else if (yysyntax_error_status == 1)
> -          {
> -            if (yymsg != yymsgbuf)
> -              YYSTACK_FREE (yymsg);
> -            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
> -            if (!yymsg)
> -              {
> -                yymsg = yymsgbuf;
> -                yymsg_alloc = sizeof yymsgbuf;
> -                yysyntax_error_status = 2;
> -              }
> -            else
> -              {
> -                yysyntax_error_status = YYSYNTAX_ERROR;
> -                yymsgp = yymsg;
> -              }
> -          }
> -        yyerror (yymsgp);
> -        if (yysyntax_error_status == 2)
> -          goto yyexhaustedlab;
> -      }
> -# undef YYSYNTAX_ERROR
> -#endif
> -    }
> -
> -  yyerror_range[1] = yylloc;
> -
> -  if (yyerrstatus == 3)
> -    {
> -      /* If just tried and failed to reuse lookahead token after an
> -         error, discard it.  */
> -
> -      if (yychar <= YYEOF)
> -        {
> -          /* Return failure if at end of input.  */
> -          if (yychar == YYEOF)
> -            YYABORT;
> -        }
> -      else
> -        {
> -          yydestruct ("Error: discarding",
> -                      yytoken, &yylval, &yylloc);
> -          yychar = YYEMPTY;
> -        }
> -    }
> -
> -  /* Else will try to reuse lookahead token after shifting the error
> -     token.  */
> -  goto yyerrlab1;
> -
> -
> -/*---------------------------------------------------.
> -| yyerrorlab -- error raised explicitly by YYERROR.  |
> -`---------------------------------------------------*/
> -yyerrorlab:
> -
> -  /* Pacify compilers like GCC when the user code never invokes
> -     YYERROR and the label yyerrorlab therefore never appears in user
> -     code.  */
> -  if (/*CONSTCOND*/ 0)
> -     goto yyerrorlab;
> -
> -  yyerror_range[1] = yylsp[1-yylen];
> -  /* Do not reclaim the symbols of the rule whose action triggered
> -     this YYERROR.  */
> -  YYPOPSTACK (yylen);
> -  yylen = 0;
> -  YY_STACK_PRINT (yyss, yyssp);
> -  yystate = *yyssp;
> -  goto yyerrlab1;
> -
> -
> -/*-------------------------------------------------------------.
> -| yyerrlab1 -- common code for both syntax error and YYERROR.  |
> -`-------------------------------------------------------------*/
> -yyerrlab1:
> -  yyerrstatus = 3;      /* Each real token shifted decrements this.  */
> -
> -  for (;;)
> -    {
> -      yyn = yypact[yystate];
> -      if (!yypact_value_is_default (yyn))
> -        {
> -          yyn += YYTERROR;
> -          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
> -            {
> -              yyn = yytable[yyn];
> -              if (0 < yyn)
> -                break;
> -            }
> -        }
> -
> -      /* Pop the current state because it cannot handle the error token.  */
> -      if (yyssp == yyss)
> -        YYABORT;
> -
> -      yyerror_range[1] = *yylsp;
> -      yydestruct ("Error: popping",
> -                  yystos[yystate], yyvsp, yylsp);
> -      YYPOPSTACK (1);
> -      yystate = *yyssp;
> -      YY_STACK_PRINT (yyss, yyssp);
> -    }
> -
> -  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
> -  *++yyvsp = yylval;
> -  YY_IGNORE_MAYBE_UNINITIALIZED_END
> -
> -  yyerror_range[2] = yylloc;
> -  /* Using YYLLOC is tempting, but would change the location of
> -     the lookahead.  YYLOC is available though.  */
> -  YYLLOC_DEFAULT (yyloc, yyerror_range, 2);
> -  *++yylsp = yyloc;
> -
> -  /* Shift the error token.  */
> -  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);
> -
> -  yystate = yyn;
> -  goto yynewstate;
> -
> -
> -/*-------------------------------------.
> -| yyacceptlab -- YYACCEPT comes here.  |
> -`-------------------------------------*/
> -yyacceptlab:
> -  yyresult = 0;
> -  goto yyreturn;
> -
> -/*-----------------------------------.
> -| yyabortlab -- YYABORT comes here.  |
> -`-----------------------------------*/
> -yyabortlab:
> -  yyresult = 1;
> -  goto yyreturn;
> -
> -#if !defined yyoverflow || YYERROR_VERBOSE
> -/*-------------------------------------------------.
> -| yyexhaustedlab -- memory exhaustion comes here.  |
> -`-------------------------------------------------*/
> -yyexhaustedlab:
> -  yyerror (YY_("memory exhausted"));
> -  yyresult = 2;
> -  /* Fall through.  */
> -#endif
> -
> -yyreturn:
> -  if (yychar != YYEMPTY)
> -    {
> -      /* Make sure we have latest lookahead translation.  See comments at
> -         user semantic actions for why this is necessary.  */
> -      yytoken = YYTRANSLATE (yychar);
> -      yydestruct ("Cleanup: discarding lookahead",
> -                  yytoken, &yylval, &yylloc);
> -    }
> -  /* Do not reclaim the symbols of the rule whose action triggered
> -     this YYABORT or YYACCEPT.  */
> -  YYPOPSTACK (yylen);
> -  YY_STACK_PRINT (yyss, yyssp);
> -  while (yyssp != yyss)
> -    {
> -      yydestruct ("Cleanup: popping",
> -                  yystos[*yyssp], yyvsp, yylsp);
> -      YYPOPSTACK (1);
> -    }
> -#ifndef yyoverflow
> -  if (yyss != yyssa)
> -    YYSTACK_FREE (yyss);
> -#endif
> -#if YYERROR_VERBOSE
> -  if (yymsg != yymsgbuf)
> -    YYSTACK_FREE (yymsg);
> -#endif
> -  return yyresult;
> -}
> -#line 528 "dtc-parser.y" /* yacc.c:1906  */
> -
> -
> -void yyerror(char const *s)
> -{
> -       ERROR(&yylloc, "%s", s);
> -}
> diff --git a/scripts/dtc/dtc-parser.tab.h_shipped b/scripts/dtc/dtc-parser.tab.h_shipped
> deleted file mode 100644
> index 6aa512c1b337..000000000000
> --- a/scripts/dtc/dtc-parser.tab.h_shipped
> +++ /dev/null
> @@ -1,125 +0,0 @@
> -/* A Bison parser, made by GNU Bison 3.0.4.  */
> -
> -/* Bison interface for Yacc-like parsers in C
> -
> -   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.
> -
> -   This program is free software: you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License as published by
> -   the Free Software Foundation, either version 3 of the License, or
> -   (at your option) any later version.
> -
> -   This program is distributed in the hope that it will be useful,
> -   but WITHOUT ANY WARRANTY; without even the implied warranty of
> -   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -   GNU General Public License for more details.
> -
> -   You should have received a copy of the GNU General Public License
> -   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
> -
> -/* As a special exception, you may create a larger work that contains
> -   part or all of the Bison parser skeleton and distribute that work
> -   under terms of your choice, so long as that work isn't itself a
> -   parser generator using the skeleton or a modified version thereof
> -   as a parser skeleton.  Alternatively, if you modify or redistribute
> -   the parser skeleton itself, you may (at your option) remove this
> -   special exception, which will cause the skeleton and the resulting
> -   Bison output files to be licensed under the GNU General Public
> -   License without this special exception.
> -
> -   This special exception was added by the Free Software Foundation in
> -   version 2.2 of Bison.  */
> -
> -#ifndef YY_YY_DTC_PARSER_TAB_H_INCLUDED
> -# define YY_YY_DTC_PARSER_TAB_H_INCLUDED
> -/* Debug traces.  */
> -#ifndef YYDEBUG
> -# define YYDEBUG 0
> -#endif
> -#if YYDEBUG
> -extern int yydebug;
> -#endif
> -
> -/* Token type.  */
> -#ifndef YYTOKENTYPE
> -# define YYTOKENTYPE
> -  enum yytokentype
> -  {
> -    DT_V1 = 258,
> -    DT_PLUGIN = 259,
> -    DT_MEMRESERVE = 260,
> -    DT_LSHIFT = 261,
> -    DT_RSHIFT = 262,
> -    DT_LE = 263,
> -    DT_GE = 264,
> -    DT_EQ = 265,
> -    DT_NE = 266,
> -    DT_AND = 267,
> -    DT_OR = 268,
> -    DT_BITS = 269,
> -    DT_DEL_PROP = 270,
> -    DT_DEL_NODE = 271,
> -    DT_PROPNODENAME = 272,
> -    DT_LITERAL = 273,
> -    DT_CHAR_LITERAL = 274,
> -    DT_BYTE = 275,
> -    DT_STRING = 276,
> -    DT_LABEL = 277,
> -    DT_REF = 278,
> -    DT_INCBIN = 279
> -  };
> -#endif
> -
> -/* Value type.  */
> -#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
> -
> -union YYSTYPE
> -{
> -#line 39 "dtc-parser.y" /* yacc.c:1909  */
> -
> -       char *propnodename;
> -       char *labelref;
> -       uint8_t byte;
> -       struct data data;
> -
> -       struct {
> -               struct data     data;
> -               int             bits;
> -       } array;
> -
> -       struct property *prop;
> -       struct property *proplist;
> -       struct node *node;
> -       struct node *nodelist;
> -       struct reserve_info *re;
> -       uint64_t integer;
> -       unsigned int flags;
> -
> -#line 99 "dtc-parser.tab.h" /* yacc.c:1909  */
> -};
> -
> -typedef union YYSTYPE YYSTYPE;
> -# define YYSTYPE_IS_TRIVIAL 1
> -# define YYSTYPE_IS_DECLARED 1
> -#endif
> -
> -/* Location type.  */
> -#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
> -typedef struct YYLTYPE YYLTYPE;
> -struct YYLTYPE
> -{
> -  int first_line;
> -  int first_column;
> -  int last_line;
> -  int last_column;
> -};
> -# define YYLTYPE_IS_DECLARED 1
> -# define YYLTYPE_IS_TRIVIAL 1
> -#endif
> -
> -
> -extern YYSTYPE yylval;
> -extern YYLTYPE yylloc;
> -int yyparse (void);
> -
> -#endif /* !YY_YY_DTC_PARSER_TAB_H_INCLUDED  */
> diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
> index fe8926bb3b54..2564a00a37d3 100755
> --- a/scripts/dtc/update-dtc-source.sh
> +++ b/scripts/dtc/update-dtc-source.sh
> @@ -34,7 +34,6 @@ DTC_LINUX_PATH=`pwd`/scripts/dtc
>  DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
>                 srcpos.h treesource.c util.c util.h version_gen.h Makefile.dtc \
>                 dtc-lexer.l dtc-parser.y"
> -DTC_GENERATED="dtc-lexer.lex.c dtc-parser.tab.c dtc-parser.tab.h"
>  LIBFDT_SOURCE="Makefile.libfdt fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
>                 fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
>                 fdt_wip.c libfdt.h libfdt_env.h libfdt_internal.h"
> @@ -59,10 +58,6 @@ for f in $DTC_SOURCE; do
>         cp ${DTC_UPSTREAM_PATH}/${f} ${f}
>         git add ${f}
>  done
> -for f in $DTC_GENERATED; do
> -       cp ${DTC_UPSTREAM_PATH}/$f ${f}_shipped
> -       git add ${f}_shipped
> -done
>  for f in $LIBFDT_SOURCE; do
>         cp ${DTC_UPSTREAM_PATH}/libfdt/${f} libfdt/${f}
>         git add libfdt/${f}
> --
> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
